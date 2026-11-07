% State combination

%load('C:\Users\tatiana\Documents\phd_research\SVM_Training_Codes\raw_data\states_GUAM_traj123modified.mat');
load('C:\Users\tatiana\Documents\phd_research\SVM_Training_Codes\raw_data\states_2026_05_26_235508.mat');
state_names = { ...
    'u', 'v', 'w', ...
    '\phi', '\theta', '\psi', ...
    'p', 'q', 'r'};

X = states(:,1:9);
for i = 1:9
    for j = i+1:9

        figure

        plot(X(:,i), X(:,j), 'b', 'LineWidth',1.5)
        hold on

        % mark initial point
        plot(X(1,i), X(1,j), 'go', ...
            'MarkerFaceColor','g')

        % mark final point
        plot(X(end,i), X(end,j), 'ro', ...
            'MarkerFaceColor','r')

        grid on
        axis equal

        xlabel(state_names{i}, 'Interpreter','tex')
        ylabel(state_names{j}, 'Interpreter','tex')

        title(sprintf('%s vs %s', ...
            state_names{j}, state_names{i}), ...
            'Interpreter','tex')
        j=j+1;

    end
end

