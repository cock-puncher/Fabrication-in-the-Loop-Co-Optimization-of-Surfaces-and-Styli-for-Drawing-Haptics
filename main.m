% feature format [measured friction, measured vibration, 0,0,0, perceived friction, perceived vibration, 0,0,0, nib radius, nib material, manufacturing process, alpha blending, mean1, deviation1, mean2, deviation2, scaling]
load('features.mat')

% the set of available stylus nibs in the format [radius, material] where material is a linear mixture from 1=rigid to 0=flexible
pen_set = {[0.5, 1], [1, 1], [2, 1], [0.5, 0], [1, 0], [2, 0]};
% the stylus nib that is currently being printed in format [printing time in seconds, expected improvement, radius, material]
print_tool = [0*60*60, 0, 0, 0];
% target haptic behavior [perceived friction, perceived vibration]
target = [-3.06 5.3];
% optimization loop itself
BayesianOptimization(features(:,11:end), features(:,1:10), pen_set, print_tool,target);