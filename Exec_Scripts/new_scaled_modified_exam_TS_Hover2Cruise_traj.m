%% sim parameters
model = 'GUAM';
userStruct.variants.refInputType = 3;

time = (0:10:320)';
N_time = length(time);

scale_list = [0.2 0.4 0.6 0.8 1.0];

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



    scale = scale_list(5);

    vel   = zeros(N_time,3);
    vel_i = zeros(N_time,3);
    chi   = zeros(N_time,1);
    chid  = zeros(N_time,1);

    pos = base_pos;

    pos(:,1) = base_pos(1,1) + scale*(base_pos(:,1)-base_pos(1,1));
    pos(:,2) = base_pos(1,2) + scale*(base_pos(:,2)-base_pos(1,2));

    h0 = -80;
    pos(:,3) = h0 + scale*(base_pos(:,3)-h0);
    pos(:,3) = min(pos(:,3),-40);

    vel_i(:,1) = gradient(pos(:,1))./gradient(time);
    vel_i(:,2) = gradient(pos(:,2))./gradient(time);
    vel_i(:,3) = gradient(pos(:,3))./gradient(time);

    chi = atan2(vel_i(:,2),vel_i(:,1));
    chi = unwrap(chi);

    for k = 2:N_time
        if norm(vel_i(k,1:2)) < 1e-3
            chi(k) = chi(k-1);
        end
    end

    chid = gradient(chi)./gradient(time);

    q = QrotZ(chi);
    vel = Qtrans(q,vel_i);

    RefInput.Vel_bIc_des = timeseries(vel,time);
    RefInput.pos_des     = timeseries(pos,time);
    RefInput.chi_des     = timeseries(chi,time);
    RefInput.chi_dot_des = timeseries(chid,time);
    RefInput.vel_des     = timeseries(vel_i,time);

    target.RefInput = RefInput;

    %% Prepare to run simulation
    % set initial conditions and add trajectory to SimInput
    simSetup;
    open(model);
