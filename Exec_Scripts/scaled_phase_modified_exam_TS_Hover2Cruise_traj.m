addpath('./Exec_Scripts/');
%% sim parameters
model = 'GUAM';

% Use timeseries input
userStruct.variants.refInputType = 3;
% 1=FOUR_RAMP, 2=ONE_RAMP, 3=Timeseries, 4=Piecewise Bezier, 5=Default(doublets)

%% setup trajectory and pass to target
time = (0:10:100)';
N_time = length(time);

scale = 0.2;   % manually change this: 0.2, 0.4, 0.6, 0.8, 1.0
phase_list = [0 pi/4 pi/2 3*pi/4];

folderPath = 'C:\Users\tatiana\Documents\phd_research\SVM_Training_Codes\raw_data';

if ~exist(folderPath,'dir')
    mkdir(folderPath);
end

base_pos = [ ...
      0     0      0
      0     0    -25
      5     0    -55
     20     0    -80
     50     5   -100
     90    15   -115
    140    35   -125
    200    70   -120
    265   115   -105
    330   160    -90
    390   180    -75
    440   160    -65
    480   110    -75
    510    40    -95
    520   -35   -115
    495  -105   -130
    440  -160   -120
    365  -190   -100
    285  -180    -80
    215  -135    -65
    165   -70    -75
    145     0    -95
    170    70   -115
    225   125   -130
    300   145   -120
    370   120   -100
    420    60    -80
    430     0    -65
    390   -45    -55
    320   -55    -65
    240   -35    -85
    180     0   -100
    140    20    -80];

addpath(genpath('lib'));

all_states = [];

for p_idx = 1:length(phase_list)

    phase = phase_list(p_idx);

    vel   = zeros(N_time,3);
    vel_i = zeros(N_time,3);
    chi   = zeros(N_time,1);
    chid  = zeros(N_time,1);

    %% Generate scaled and phase-shifted trajectory

    pos = base_pos;

    % Scale x and y relative to starting point
    pos(:,1) = base_pos(1,1) + scale*(base_pos(:,1)-base_pos(1,1));
    pos(:,2) = base_pos(1,2) + scale*(base_pos(:,2)-base_pos(1,2));

    % Add phase-varying lateral perturbations
    pos(:,2) = pos(:,2) ...
        + scale*100*sin(2*pi*time/90 + phase) ...
        + scale*50*sin(2*pi*time/35 + 2*phase);

    % Scale altitude around nominal altitude
    h0 = -80;
    pos(:,3) = h0 + scale*(base_pos(:,3)-h0);

    % Add phase-varying altitude perturbations
    pos(:,3) = pos(:,3) ...
        - scale*100*sin(2*pi*time/75 + phase) ...
        - scale*150*sin(2*pi*time/30 + 2*phase);

    % Prevent crossing ground
    pos(:,3) = min(pos(:,3),-40);

    %% Compute inertial velocity

    vel_i(:,1) = gradient(pos(:,1))./gradient(time);
    vel_i(:,2) = gradient(pos(:,2))./gradient(time);
    vel_i(:,3) = gradient(pos(:,3))./gradient(time);

    %% Compute heading

    chi = atan2(vel_i(:,2),vel_i(:,1));
    chi = unwrap(chi);

    for k = 2:N_time
        if norm(vel_i(k,1:2)) < 1e-3
            chi(k) = chi(k-1);
        end
    end

    chid = gradient(chi)./gradient(time);

    %% Convert inertial velocity to heading frame

    q = QrotZ(chi);
    vel = Qtrans(q,vel_i);

    %% Setup trajectory to match GUAM bus

    RefInput.Vel_bIc_des = timeseries(vel,time);
    RefInput.pos_des     = timeseries(pos,time);
    RefInput.chi_des     = timeseries(chi,time);
    RefInput.chi_dot_des = timeseries(chid,time);
    RefInput.vel_des     = timeseries(vel_i,time);

    target.RefInput = RefInput;

    %% Run simulation

    %% Prepare to run simulation
    % set initial conditions and add trajectory to SimInput
    simSetup;
    open(model);
    % Execute the model
    sim(model);
    
    %% Extract SimOut from logsout
    SimOut = logsout{1}.Values;
    
    %% Extract and save states for this phase
    states = state_extraction(SimOut);

    fileName = fullfile(folderPath, ...
        sprintf('states_scale_%03d_phase_%03d.mat', ...
        round(scale*100), ...
        round(rad2deg(phase))));

    save(fileName,'states');
    clear states;

    %% Append to combined scale dataset

    %all_states = [all_states; states];

end