%% sim parameters
model = 'GUAM';
% use timeseries input
userStruct.variants.refInputType=3; % 1=FOUR_RAMP, 2= ONE_RAMP, 3=Timeseries, 4=Piecewise Bezier, 5=Default(doublets)

%% setup trajectory and pass to target
% time        = [0 20 40]'; % Column vector of time points
time = (0:10:320)'; 
 % Column vector of time points
N_time = length(time);

scale_list = [0.15 0.2 0.25 0.25 0.4 0.5 0.6 0.7 0.8 0.9 1.0];

folderPath = 'C:\Users\tatiana\Documents\phd_research\SVM_Training_Codes\raw_data';

% define trajectory as hovering climb and then acceleration to forward flight
% prescibe inertial position (NED)
% pos     = [0 0 0; 0 0 -80; 150 0 -100]; % Inertial Positions (x,y,-z) row vector for each time
% Inertial position in NED: [x, y, z]
% z is negative altitude
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


for s_idx = 1:length(scale_list)

    scale = scale_list(s_idx);

    vel     = zeros(N_time, 3);
    vel_i   = zeros(N_time, 3);
    pos     = zeros(N_time, 3);
    chi     = zeros(N_time, 3);
    chid    = zeros(N_time, 3);


    pos = base_pos;

    % Keep starting point fixed, scale maneuver relative to initial point
    pos(:,1) = base_pos(1,1) + scale*(base_pos(:,1) - base_pos(1,1));
    pos(:,2) = base_pos(1,2) + scale*(base_pos(:,2) - base_pos(1,2));

    pos(:,2) = pos(:,2) ...
        + scale*30*sin(2*pi*time/90) ...
        + scale*10*sin(2*pi*time/120);

    
    % Scale altitude excursions around nominal altitude
    h0 = -80;
    pos(:,3) = ...
        -h0 ...
        - 30*sin(2*pi*time/250) ...
        - 20*sin(2*pi*time/120) ...;
    
    % Prevent crossing ground
    pos(:,3) = min(pos(:,3), -40);

    % Then compute velocity
    vel_i(:,1) = gradient(pos(:,1))./gradient(time);
    vel_i(:,2) = gradient(pos(:,2))./gradient(time);
    vel_i(:,3) = gradient(pos(:,3))./gradient(time);
    
    % Run simulation here and save states as states_scale_s_idx


    % Optional: force hover-like endpoints
    %vel_i(1,:)   = [0 0 -4];
    %vel_i(end,:) = [0 0  0];
    
    % Compute heading
    chi     = atan2(vel_i(:,2),vel_i(:,1));
    
    % Avoid undefined heading during near-hover points
    for k = 2:N_time
        if norm(vel_i(k,1:2)) < 1e-3
            chi(k) = chi(k-1);
        end
    end

    % Heading rate
    chid = gradient(chi)./gradient(time);
    
    % add stars library blocks for quaternion functions
    addpath(genpath('lib'));
    
    % compute velocity in heading frame
    q = QrotZ(chi);
    vel = Qtrans(q,vel_i);

    % setup trajectory to match bus
    RefInput.Vel_bIc_des    = timeseries(vel,time); % Heading frame velocity
    RefInput.pos_des        = timeseries(pos,time); % Inertial Position
    RefInput.chi_des        = timeseries(chi,time); % Heading Angle
    RefInput.chi_dot_des    = timeseries(chid,time); % Heading Angle Rate
    RefInput.vel_des        = timeseries(vel_i,time); % Inertial Position
    
    target.RefInput = RefInput;

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
        sprintf('states_scale_%03d.mat',round(scale*100)));

    save(fileName,'states');
    clear states;

    % Append to combined scale dataset

    %all_states = [all_states; states];

end