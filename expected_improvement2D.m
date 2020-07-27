function [EI] = expected_improvement2D(mu_f, sigma_f, mu_v, sigma_v, F, V, d_star, zeta)
    % limit over exploitation of data
    dir = normr([mu_f - F, mu_v-V]);
    mu_f = mu_f + zeta*dir(1);
    mu_v = mu_v + zeta*dir(2);
    
    d = sqrt(d_star/2);
    
    nf = (sigma_f/sqrt(2*pi*sigma_f^2))*(sigma_v/sqrt(2*pi*sigma_v^2))/4;
    m = -d_star + (F-mu_f)^2 + sigma_f^2;
    l = -sqrt(2*pi)*(erf((d+F-mu_f)/(sqrt(2)*sigma_f)) + erf((d-F+mu_f)/(sqrt(2)*sigma_f)));
    k = 2*sigma_f*((d+F-mu_f)*exp(-(d-F+mu_f)^2/(2*sigma_f^2)) + (d-F+mu_f)*exp(-(d+F-mu_f)^2/(2*sigma_f^2)));
    
    EI = nf*(sqrt(2*pi)*(k+l*(m+sigma_v^2+(V-mu_v)^2))*(erf((d-mu_v+V)/(sqrt(2)*sigma_v)) + erf((d+mu_v-V)/(sqrt(2)*sigma_v))) -...
        2*l*sigma_v*((d-mu_v+V)*exp(-(d+mu_v-V)^2/(2*sigma_v^2)) + (d+mu_v-V)*exp(-(d-mu_v+V)^2/(2*sigma_v^2))));
end
