% SVM Boundaryload('svm_model_GUAM2_prate_qrate.mat');   %really is pitch vs pitch rate
%load('C:\Users\tatiana\Documents\phd_research\SVM_Training_Codes\svm_boundary_output\svm_model_GUAM2_pitch_qrate.mat');
load('C:\Users\tatiana\Documents\phd_research\SVM_Training_Codes\svm_boundary_output\svm_model_GUAM2_pitch_pitchrate.mat');

%Post-process data to visualize K
nSV = size(K,3);

K_cell = cell(nSV,1);

for k = 1:nSV
    K_cell{k} = K(:,:,k);
end
% ----- Plot boundary -----
figure;
% Filled regions
contourf(X, Y, H, [min(H(:)) 0 max(H(:))], ...
    'LineStyle', 'none');
hold on;
% Decision boundary h(x,y) = 0
contour(X, Y, H, [0 0], ...
    'k', ...
    'LineWidth', 2);
colorbar;

xlabel('x_{pos}');
ylabel('y_{pos}');
title('SVM Boundary h(x)=0');

xlim([min(x_vals) max(x_vals)]);
ylim([min(y_vals) max(y_vals)]);

axis tight;
axis normal;
grid on;
box on;

set(gca, 'FontSize', 12);

%% Extract all points on zero-level set h(x,y)=0

C = contourc(x_vals, y_vals, H, [0 0]);

zeroPts = [];
idx = 1;

while idx < size(C,2)

    level = C(1,idx);      % should be 0
    npts  = C(2,idx);      % number of points in this contour segment

    pts = C(:, idx+1:idx+npts)';   % npts x 2 array: [x y]

    zeroPts = [zeroPts; pts];

    idx = idx + npts + 1;
end

zeroPts_rad(:,1) = zeroPts(:,1)*pi/180;
zeroPts_rad(:,2) = zeroPts(:,2)*pi/180;



save('SVM_boundary_theta_q.mat','zeroPts_rad')

%% Plot extracted zero-level-set points
figure;
contour(X,Y,H,[0 0],'k','LineWidth',2);
hold on;
plot(zeroPts_rad(:,1), zeroPts_rad(:,2), 'r.', 'MarkerSize', 8);
plot(theta_proj,q_proj)

figure
plot(zeroPts_rad(:,1), zeroPts_rad(:,2), 'r.', 'MarkerSize', 8);
hold on
plot(theta_proj_rad,q_proj_rad, LineWidth=0.8);
plot(theta_orig_rad,q_orig_rad,'b');
plot(theta_orig_rad(1,1),q_orig_rad(1,1),'g.','MarkerSize', 20);
plot(theta_proj_rad(1,1),q_proj_rad(1,1),'b.','MarkerSize', 20);
legend('zerolevelset','y_{proj} (rad)', 'y (rad)')


% figure
% plot(states(:,5),states(:,8))
plot(theta_proj_rad(1,1),q_proj_rad(1,1),'g.','MarkerSize', 12);


figure
plot(time,simout_idxmin.signals.values(:,1))
hold on

figure
plot(simout_idxmin.signals.values(:,1))

figure
plot(theta_proj_rad,q_proj_rad);
hold on
plot(theta_proj_rad(58190,1),q_proj_rad(58190,1),'g.','MarkerSize', 20);


%%%
temp1= own_traj{:,1}; temp2= own_traj{:,2}; temp3= own_traj{:,3};
first_col = temp1(:,1); second_col=temp2(:,1); third_col = temp3(:,1);
figure
plot(first_col(:,1),second_col(:,1))
plot3(first_col(:,1),second_col(:,1),third_col(:,1))