%projection difference 

%theta = SimOut.Vehicle.Sensor.Euler.theta.Data * 180/pi;
%q = SimOut.Vehicle.Sensor.Omeg_BIb.Data(:,2) * 180/pi;

theta_orig = simout_yorig.signals.values(:,2)*180/pi;
q_orig = simout_yorig.signals.values(:,1)*180/pi;

theta_orig_rad = simout_yorig.signals.values(:,2);
q_orig_rad = simout_yorig.signals.values(:,1);

theta_proj = simout_yproj.signals.values(:,2)*180/pi;
q_proj = simout_yproj.signals.values(:,1)*180/pi;

theta_proj_rad = simout_yproj.signals.values(:,2);
q_proj_rad = simout_yproj.signals.values(:,1);

theta_diff = theta_orig-theta_proj;
q_diff = q_orig-q_proj;

theta_diff_rad = theta_orig_rad-theta_proj_rad;
q_diff_rad = q_orig_rad-q_proj_rad;


tol = 1e-6;

theta_changed = any(abs(theta_diff) > tol);
q_changed     = any(abs(q_diff) > tol);

theta_changed_rad = sum(abs(theta_diff_rad) > tol);
q_changed_rad     = sum(abs(q_diff_rad) > tol);

disp(['Theta was projected: ', num2str(theta_changed_rad), ' times'])
disp(['q was projected: ', num2str(q_changed_rad), ' times'])

% Tolerance for detecting projection
tol = 1e-6;

% Identify indices where projection occurred
idx_theta_changed = find(abs(theta_diff_rad) > tol);
idx_q_changed = find(abs(q_diff_rad) > tol);

% Combined indices where either theta or q was projected
idx_yproj_changed = find(abs(theta_diff_rad) > tol | abs(q_diff_rad) > tol);

% Number of projected time steps
n_theta = numel(idx_theta_changed);
n_q = numel(idx_q_changed);
n_yproj = numel(idx_yproj_changed);

% Display results
disp(['Theta was projected: ', num2str(n_theta), ' times'])
disp(['q was projected: ', num2str(n_q), ' times'])
disp(['Total time steps with projection: ', num2str(n_yproj)])

%%%% Check matrices Ap over time history
Ap = simout_Ap.signals.values;

Ap(:,:,1)       % First matrix
Ap(:,:,1000)    % Matrix at step 1000
Ap(:,:,32000)   % Matrix at step 32000
Ap(:,:,64001)   % Last matrix