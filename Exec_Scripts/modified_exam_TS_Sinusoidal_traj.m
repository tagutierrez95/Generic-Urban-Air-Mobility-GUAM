%% sim parameters
model = 'GUAM';
% use timeseries input
userStruct.variants.refInputType=3; % 1=FOUR_RAMP, 2= ONE_RAMP, 3=Timeseries, 4=Piecewise Bezier, 5=Default(doublets)

%% setup trajectory and pass to target
dt = 1;
Tfinal = 200;
time = (0:dt:Tfinal)';
N_time = length(time);

vel     = zeros(3,N_time)';
vel_i   = zeros(3,N_time)';
pos     = zeros(3,N_time)';
chi     = zeros(1,N_time)';
chid    = zeros(1,N_time)';


% define trajectory as sinusoidal variations
% prescribe position (NED)
h0 = 100;      % nominal altitude (ft)

% define trajectory as sinusoidal variations
% prescribe position (NED)
% Vx = 8;      % forward speed, ft/s
% Ay = 40;     % lateral amplitude, ft
% h0 = 100;    % nominal altitude, ft
% Az = 20;     % altitude oscillation amplitude, ft
% T  = 120;    % sinusoidal period, sec
% 
% %pos(:,1) = time;
% %pos(:,2) = 10*cos(2*pi/300*time);
% %pos(:,3) = -10*sin(2*pi/300*time);
% 
% omega = 2*pi/T;
% 
% pos(:,1) = Vx*time;
% pos(:,2) = Ay*cos(omega*time);
% pos(:,3) = -h0 - Az*sin(omega*time);

%% Piecewise multi-frequency sinusoidal trajectory

h0 = 100;              % nominal altitude, ft

for k = 1:N_time

    t = time(k);
    pos(k,1) = 8*t;

     % Multi-frequency lateral excitation
    pos(k,2) = ...
          30*cos(2*pi*t/250) ...
        + 20*cos(2*pi*t/120) ...
        + 15*cos(2*pi*t/60) ...
        + 10*cos(2*pi*t/30);

    % Multi-frequency altitude excitation
    % NED convention
    pos(k,3) = ...
        -h0 ...
        - 30*sin(2*pi*t/250) ...
        - 20*sin(2*pi*t/120) ...
        - 15*sin(2*pi*t/60) ...
        - 10*sin(2*pi*t/30);


    % % Segment 1: mild motion
    % if t <= 100
    % 
    %     Vx = 6;
    %     Ay = 10;
    %     Az = 10;
    %     Ty = 300;
    %     Tz = 300;
    % 
    % % Segment 2: medium pitch/altitude excitation
    % elseif t <= 200
    % 
    %     Vx = 9;
    %     Ay = 5;
    %     Az = 5;
    %     Ty = 200;
    %     Tz = 200;
end
    % 
    % omega_y = 2*pi/Ty;
    % omega_z = 2*pi/Tz;
    % 
    % % Forward position
    % pos(k,1) = t;
    % 
    % % Lateral sinusoidal motion
    % pos(k,2) = Ay*cos(omega_y*t);
    % 
    % % Altitude sinusoidal motion, NED convention
    % pos(k,3) = Az*sin(omega_z*t);

% end


% compute velocity
vel_i(:,1) = gradient(pos(:,1))./gradient(time);
vel_i(:,2) = gradient(pos(:,2))./gradient(time);
vel_i(:,3) = gradient(pos(:,3))./gradient(time);

% compute heading
chi     = atan2(vel_i(:,2),vel_i(:,1));
chi = unwrap(chi);
chid    = gradient(chi)./gradient(time);

% add stars library blocks for quaternion functions
addpath(genpath('lib'));

% compute velocity in heading frame
q = QrotZ(chi);
vel = Qtrans(q,vel_i);

% setup trajectory to match bus
RefInput.Vel_bIc_des    = timeseries(vel,time);
RefInput.pos_des        = timeseries(pos,time);
RefInput.chi_des        = timeseries(chi,time);
RefInput.chi_dot_des    = timeseries(chid,time);
RefInput.vel_des        = timeseries(vel_i,time);

target.RefInput = RefInput;

%% Prepare to run simulation
% set initial conditions and add trajectory to SimInput
simSetup;
open(model);