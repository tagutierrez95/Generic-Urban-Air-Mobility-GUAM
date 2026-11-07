% Processing

states = state_extraction(SimOut);

% Define folder path
folderPath = 'C:\Users\tatiana\Documents\phd_research\SVM_Training_Codes\raw_data';

timestamp = datestr(now,'yyyy_mm_dd_HHMMSS');
fileName = fullfile(folderPath, ['states_scale10_' timestamp '.mat']);

save(fileName, 'states');

disp(['States saved to: ', fileName])

%% Stack up all trajectories

clc;clear all; close all;

load('C:\Users\tatiana\Documents\phd_research\SVM_Training_Codes\raw_data\states_2026_05_25_233047.mat');

States_GUAM2 = states;
clear states;
load('C:\Users\tatiana\Documents\phd_research\SVM_Training_Codes\raw_data\states_2026_05_25_194049.mat');
States_GUAM1 = states;
clear states;
% load('C:\Users\tatiana\Documents\phd_research\SVM_Training_Codes\raw_data\states_2026_05_17_221454.mat');
% States_GUAM1 = states;
% clear states;
load('C:\Users\tatiana\Documents\phd_research\SVM_Training_Codes\raw_data\states_2026_05_18_200301.mat');
States_GUAM4 = states;
% clear states;
% 
% states = [States_GUAM1; States_GUAM2; States_GUAM3; States_GUAM4];
states = [States_GUAM1; States_GUAM2; States_GUAM4];
% states = [States_GUAM1; States_GUAM2]



% Define folder path
folderPath = 'C:\Users\tatiana\Documents\phd_research\SVM_Training_Codes\raw_data';

% Full file path
fileName = fullfile(folderPath, ...
    ['states_GUAM_traj12.mat']);

% Save variable
save(fileName, 'states');

disp(['Saved to: ', fileName])


%% Test 

load('C:\Users\tatiana\Documents\phd_research\SVM_Training_Codes\raw_data\states_GUAM_traj123.mat');
States_GUAM123 = states;
clear states;

load('C:\Users\tatiana\Documents\phd_research\SVM_Training_Codes\raw_data\states_2026_05_26_202018.mat');
States_GUAM12modified = states;
clear states;

states = [States_GUAM123; States_GUAM12modified];

% Define folder path
folderPath = 'C:\Users\tatiana\Documents\phd_research\SVM_Training_Codes\raw_data';

% Full file path
fileName = fullfile(folderPath, ...
    ['states_GUAM_traj123modified.mat']);

% Save variable
save(fileName, 'states');

disp(['Saved to: ', fileName])

%% 
load('C:\Users\tatiana\Documents\phd_research\SVM_Training_Codes\raw_data\states_GUAM_traj123.mat');
States_GUAM123 = states;
clear states;

load('C:\Users\tatiana\Documents\phd_research\SVM_Training_Codes\raw_data\states_2026_05_26_235508.mat');
States_GUAM_GPT = states;
clear states;

load('C:\Users\tatiana\Documents\phd_research\SVM_Training_Codes\raw_data\states_2026_05_28_215012.mat');
States_GUAM_sinusoid = states;
clear states;

% 

load('C:\Users\tatiana\Documents\phd_research\SVM_Training_Codes\raw_data\states_sin52026_05_28_223809.mat');
States_GUAM_sin5 = states;
clear states;
load('C:\Users\tatiana\Documents\phd_research\SVM_Training_Codes\raw_data\states_sin102026_05_28_224443.mat');
States_GUAM_sin10 = states;
clear states;
load('C:\Users\tatiana\Documents\phd_research\SVM_Training_Codes\raw_data\states_sin2015105_2026_05_28_225455.mat');
States_GUAM_sin20 = states;
clear states;
load('C:\Users\tatiana\Documents\phd_research\SVM_Training_Codes\raw_data\states_sin30201510_2026_05_28_230253.mat');
States_GUAM_sin30 = states;
clear states;
%states = [States_GUAM123; States_GUAM_GPT];
states = [States_GUAM123; States_GUAM_GPT; States_GUAM_sin5; States_GUAM_sin10; States_GUAM_sin20; States_GUAM_sin30];

figure
plot(states(:,5),states(:,8))
hold on
plot(States_GUAM_GPT(:,5),States_GUAM_GPT(:,8))
hold on
plot(States_GUAM123(:,5),States_GUAM123(:,8))
plot(States_GUAM_sinusoid(:,5),States_GUAM_sinusoid(:,8))
hold on
plot(States_GUAM_GPT(:,5),States_GUAM_GPT(:,8))


% Define folder path
folderPath = 'C:\Users\tatiana\Documents\phd_research\SVM_Training_Codes\raw_data';

% Full file path
fileName = fullfile(folderPath, ...
    ['states_GUAM_sin5102030.mat']);

% Save variable
save(fileName, 'states');

disp(['Saved to: ', fileName])


load('C:\Users\tatiana\Documents\phd_research\SVM_Training_Codes\raw_data\states_scale1_2026_05_30_223345.mat');
States_GUAM_scale1 = states;
clear states;
load('C:\Users\tatiana\Documents\phd_research\SVM_Training_Codes\raw_data\states_scale08_2026_05_30_222818.mat');
States_GUAM_scale08 = states;
clear states;
load('C:\Users\tatiana\Documents\phd_research\SVM_Training_Codes\raw_data\states_scale06_2026_05_30_222306.mat');
States_GUAM_scale06 = states;
clear states;
load('C:\Users\tatiana\Documents\phd_research\SVM_Training_Codes\raw_data\states_scale04_2026_05_30_221755.mat');
States_GUAM_scale04 = states;
clear states;
load('C:\Users\tatiana\Documents\phd_research\SVM_Training_Codes\raw_data\states_scale02_2026_05_30_221343.mat');
States_GUAM_scale02 = states;
clear states;

states = [States_GUAM_scale1; States_GUAM_scale08; States_GUAM_scale06; States_GUAM_scale04; States_GUAM_scale02; States_GUAM123; States_GUAM_sinusoid; States_GUAM_GPT; States_GUAM_sin5; States_GUAM_sin10; States_GUAM_sin20; States_GUAM_sin30];

figure
plot(states(:,5),states(:,8))

% Full file path
fileName = fullfile(folderPath, ...
    ['states_GUAM_scale_sin.mat']);

% Save variable
save(fileName, 'states');

disp(['Saved to: ', fileName])


%% 
% scale and phase

state_vector = [states_scale_020_phase_000, states_scale_020_phase_045, states_scale_020_phase_090, states_scale_020_phase_135, states_scale_040_phase_000, states_scale_040_phase_045, states_scale_040_phase_090, states_scale_040_phase_135, states_scale_060_phase_000, states_scale_060_phase_045, states_scale_060_phase_090, states_scale_060_phase_135, states_scale_080_phase_000, states_scale_080_phase_045, states_scale_080_phase_090, states_scale_080_phase_135, states_scale_100_phase_000, states_scale_100_phase_045, states_scale_100_phase_090, states_scale_100_phase_135];

%% Load all scaled-phase datasets

folderPath = 'C:\Users\tatiana\Documents\phd_research\SVM_Training_Codes\raw_data';

%scale_values = [20 40 60 80 100];
scale_values = [20];
phase_values = [000 045 090 0135];

state_vector = [];

for s = scale_values

    for p = phase_values

        fileName = fullfile(folderPath, ...
            sprintf('states_scale_%03d_phase_%03d.mat',s,p));

        fprintf('Loading %s\n',fileName)

        tmp = load(fileName);

        % Each file contains variable "states"
        state_vector = [state_vector; tmp.states];

    end

end

load('C:\Users\tatiana\Documents\phd_research\SVM_Training_Codes\raw_data\states_GUAM_traj123.mat');
States_GUAM123 = states;
clear states;

load('C:\Users\tatiana\Documents\phd_research\SVM_Training_Codes\raw_data\states_2026_05_26_235508.mat');
States_GUAM_GPT = states;
clear states;

% Each file contains variable "states"
        states = [state_vector; States_GUAM123; States_GUAM_GPT; States_GUAM_scale1; States_GUAM_scale08; States_GUAM_scale06; States_GUAM_scale04; States_GUAM_scale02; States_GUAM_sin5; States_GUAM_sin10; States_GUAM_sin20; States_GUAM_sin30];

        states_plot = [state_vector; States_GUAM123; States_GUAM_GPT];
figure(3)
plot(states_plot(:,5),states_plot(:,8))

figure(4)
plot(state_vector(:,5),state_vector(:,8))

% Full file path
fileName = fullfile(folderPath, ...
    ['states_GUAM_scalephase.mat']);

% Save variable
save(fileName, 'states');

disp(['Saved to: ', fileName])

%%

folderPath = 'C:\Users\tatiana\Documents\phd_research\SVM_Training_Codes\raw_data';

scale_values = [015 020 025 040 050 060 070 080 090 100];

state_vector = [];

for s = scale_values


        fileName = fullfile(folderPath, ...
            sprintf('states_scale_%03d.mat',s));

        fprintf('Loading %s\n',fileName)

        tmp = load(fileName);

        % Each file contains variable "states"
        state_vector2 = [state_vector; tmp.states];


end

states = [state_vector2];

figure
plot(states(:,5),states(:,8));






%% Working based on test.m - June 1st

load('C:\Users\tatiana\Documents\phd_research\SVM_Training_Codes\raw_data\states_GUAM_traj123.mat');
States_GUAM123 = states;
clear states;

load('C:\Users\tatiana\Documents\phd_research\SVM_Training_Codes\raw_data\states_scale_100_phase_000.mat');
States_GUAM_sin100 = states;
clear states;

load('C:\Users\tatiana\Documents\phd_research\SVM_Training_Codes\raw_data\states_scale_100_phase_090.mat');
States_GUAM_sin090 = states;
clear states;

load('C:\Users\tatiana\Documents\phd_research\SVM_Training_Codes\raw_data\states_scale_100_phase_180.mat');
States_GUAM_sin180 = states;
clear states;

load('C:\Users\tatiana\Documents\phd_research\SVM_Training_Codes\raw_data\states_scale_080_phase_000.mat');
States_GUAM_sin080_000 = states;
clear states;

load('C:\Users\tatiana\Documents\phd_research\SVM_Training_Codes\raw_data\states_scale_080_phase_090.mat');
States_GUAM_sin080_090 = states;
clear states;

load('C:\Users\tatiana\Documents\phd_research\SVM_Training_Codes\raw_data\states_scale_080_phase_180.mat');
States_GUAM_sin080_180 = states;
clear states;

load('C:\Users\tatiana\Documents\phd_research\SVM_Training_Codes\raw_data\states_scale_050_phase_000.mat');
States_GUAM_sin050_000 = states;
clear states;

load('C:\Users\tatiana\Documents\phd_research\SVM_Training_Codes\raw_data\states_scale_050_phase_090.mat');
States_GUAM_sin050_090 = states;
clear states;

load('C:\Users\tatiana\Documents\phd_research\SVM_Training_Codes\raw_data\states_scale_050_phase_180.mat');
States_GUAM_sin050_180 = states;
clear states;

load('C:\Users\tatiana\Documents\phd_research\SVM_Training_Codes\raw_data\states_scale_025_phase_000.mat');
States_GUAM_sin025_000 = states;
clear states;

load('C:\Users\tatiana\Documents\phd_research\SVM_Training_Codes\raw_data\states_scale_025_phase_090.mat');
States_GUAM_sin025_090 = states;
clear states;

load('C:\Users\tatiana\Documents\phd_research\SVM_Training_Codes\raw_data\states_scale_025_phase_180.mat');
States_GUAM_sin025_180 = states;
clear states;

states = [States_GUAM_sin100; States_GUAM_sin090; States_GUAM_sin180; ...
    States_GUAM_sin080_000; States_GUAM_sin080_090; States_GUAM_sin080_180; ...
    States_GUAM_sin050_000; States_GUAM_sin050_090; States_GUAM_sin050_180; ...
    States_GUAM_sin025_000; States_GUAM_sin025_090; States_GUAM_sin025_180];

plot(states(:,7),states(:,8))   % 

% Full file path
fileName = fullfile(folderPath, ...
    ['states_GUAM_scale_sin_.mat']);

% Save variable
save(fileName, 'states');

disp(['Saved to: ', fileName])
