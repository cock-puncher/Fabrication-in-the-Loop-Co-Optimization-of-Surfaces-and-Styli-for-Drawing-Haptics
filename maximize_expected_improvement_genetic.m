function [EI, new_x] = maximize_expected_improvement_genetic(f_improvement, do_pen, evals)
%UNTITLED12 Summary of this function goes here
%   Detailed explanation goes here
    rng('shuffle')
    if nargin < 3
        evals = 1000;
    end
    if do_pen <= 0
        nvars = 2 + 1;%2 + 5 + 1;
        bounds = [...
            0.5, 2;... % tip radius
            0, 1;... % tip material
            1, -do_pen % surface
            ];
        options = optimoptions('ga', 'Generations',1e4, 'PlotFcn',@gaplotbestf);
        [new_x, EI] = ga(f_improvement,nvars,[],[],[],[],bounds(:,1),bounds(:,2),[],[3],options);
    else
        nvars = 0 + 7 + 1;
        bounds = [...
            1, do_pen;... % pen selection
            0, 2;... % manufacturing method
            0, 1;... % alpha blend
            0.1, 10;... % f_0
            0, 10;... % simga_0
            0.1, 10;... % f_1
            0, 10;... % sigma_1
            0, 1 ... % scaling
            ];
        options = optimoptions('ga', 'Generations',1e4, 'PlotFcn',@gaplotbestf);
        [new_x, EI] = ga(f_improvement,nvars,[],[],[],[],bounds(:,1),bounds(:,2),[],[1,2],options);
    end
end