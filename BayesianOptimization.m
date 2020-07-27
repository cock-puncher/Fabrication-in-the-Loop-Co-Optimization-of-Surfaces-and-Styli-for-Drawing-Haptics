function [] = BayesianOptimization(x, y, pen_set, print_tool, target)
%UNTITLED5 Summary of this function goes here
%   Detailed explanation goes here

% use the first 6 initial surfaces + all new observations
surface_set = [x(1:6,3:end); x(36:end,3:end)];

features_x = x;
source_y = y;
y = y(:,6:7);

% find closest sample to target
ds = sum((y-target).^2, 2);
[best_distance, best_idx] = min(ds);
best_friction = sqrt((y(best_idx, 1)-target(1))^2);
best_vibration = sqrt((y(best_idx, 2)-target(2))^2);
% fit GP proxy
[gpr_friction, gpr_vibration] = fit_GP_proxy(x,y);
% optimize for additional drawing stylus to print
zeta = 0.1;
manufacturing_time = 3*60*60; % expected manufacturing time of a new stylus nib
[EI, new_x] = maximize_expected_improvement_genetic(@evaluate_improvement_tool, -size(surface_set,1), 1e4);
new_x
if isempty(print_tool) || print_tool(1) == 0 || print_tool(2)/print_tool(1) > EI/manufacturing_time
    new_x = [new_x(1), new_x(2), surface_set(new_x(3),:)];
    [mu_friction, sigma_friction] = predict(gpr_friction, new_x);
    [mu_vibration, sigma_vibration] = predict(gpr_vibration, new_x);
    fprintf('Start printing new tool! (%f, %f | %f) with predicted (%f,%f | %f,%f)\n', new_x(1), new_x(2), EI, mu_friction, sigma_friction, mu_vibration, sigma_vibration);
    print_tool = [manufacturing_time, EI, new_x(1), new_x(2)];
    csvwrite('new_tool.csv', print_tool);
end
% maximize expected improvement for each tool in the set
tic
[EI, new_x] = maximize_expected_improvement_genetic(@evaluate_improvement, numel(pen_set), 1e4);
toc
% use tool with maximum improvement
new_x = [pen_set{new_x(1)}, new_x(2:end)]
csvwrite('new_sample.csv', new_x);
% generate surface pattern
G = [new_x(4), new_x(5), new_x(6); 1-new_x(4), new_x(7), new_x(8)];
p = GeneratePatternFrequency(G, 200*20, new_x(9), 'optimized');
figure;
imshow(p(1:256,1:256));
[mu_friction, sigma_friction] = predict(gpr_friction, new_x);
[mu_vibration, sigma_vibration] = predict(gpr_vibration, new_x);
fprintf('Please measure sample with EI = %f with predicted (%f,%f | %f,%f)\n', EI, mu_friction, sigma_friction, mu_vibration, sigma_vibration);
fprintf('Predicted ');
for i =1:4
    [mu_friction, sigma_friction] = predict(gpr_friction, [pen_set{i}, new_x(3:end)]);
    [mu_vibration, sigma_vibration] = predict(gpr_vibration, [pen_set{i}, new_x(3:end)]);
    fprintf('(%.2f,%.2f | %.2f,%.2f) ', mu_friction, sigma_friction, mu_vibration, sigma_vibration);
end
fprintf('\n');
% MANUAL: measure sample to place in perceptual space


    function [u] = evaluate_improvement(x)
        x = x';
        x = [pen_set{x(1)}(1);pen_set{x(1)}(2);x(2:end)];
        [mu_friction, sigma_friction] = predict(gpr_friction, x');
        [mu_vibration, sigma_vibration] = predict(gpr_vibration, x');
        
        u = expected_improvement2D(mu_friction, sigma_friction, mu_vibration, sigma_vibration, target(1), target(2), best_distance, 0.1);
        u = -u;
    end
    function [u] = evaluate_improvement_tool(x)
        x = [x(1),x(2),surface_set(x(3),:)];
        [mu_friction, sigma_friction] = predict(gpr_friction, x);
        [mu_vibration, sigma_vibration] = predict(gpr_vibration, x);
        
        u = expected_improvement2D(mu_friction, sigma_friction, mu_vibration, sigma_vibration, target(1), target(2), best_distance, zeta);
        u = -u;
    end

end
