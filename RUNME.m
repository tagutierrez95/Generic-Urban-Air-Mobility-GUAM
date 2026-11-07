1% This script is a toplevel script that executes the users desired example case:

addpath('./Exec_Scripts/');
u_choice = input(sprintf('Specify the desired example case to run:\n\t(1) Sinusoidal Timeseries\n\t(2) Hover to Transition Timeseries\n\t(3) Cruise Climbing Turn Timeseries\n\t(4) Ramp demo\n\t(5) Piecewise Bezier Trajectory\nUser Input: '));

switch u_choice
    case 1
        exam_TS_Sinusoidal_traj;
    case 2
        exam_TS_Hover2Cruise_traj
    case 3
        exam_TS_Cruise_Climb_Turn_traj
    case 4
        exam_RAMP
    case 5 
        if ~exist("userStruct",'var')
            addpath('./Bez_Functions/');
        end
        exam_Bezier;
    case 6
        modified2_exam_TS_Hover2Cruise_traj
    case 7
        modified_exam_TS_Sinusoidal_traj
    case 8
        scaled_modified_exam_TS_Hover2Cruise_traj
    case 9 
        test

    otherwise
        fprintf('User needs to supply selection choice (1-5)\n')
        return
end

load('SVM_boundary_theta_q.mat');  %added to load ZeroPts from SVM HMS
% Execute the model
sim(model);
% Create sample output plots
simPlots_GUAM;