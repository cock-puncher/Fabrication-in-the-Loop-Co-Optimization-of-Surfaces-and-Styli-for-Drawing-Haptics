function [I] = GeneratePatternFrequency(G, N, scaling, fname)
rng default

F = linspace(0,1-1/N,N)*20;
noise = wgn(N,N,1);
Y = fft2(noise);
Y = fftshift(Y);
for i=1:N
    for j=1:N
        r = sqrt((F(i) - 0.5*20)^2 + (F(j) - 0.5*20)^2);
        scale = 0;
        for k=1:size(G,1)
            scale = scale + G(k,1)*exp(-(r-G(k,2))^2/(2*G(k,3)^2));
        end
        Y(i, j) = Y(i, j)*scale;
    end
end
I = ifft2(ifftshift(Y));
I = real(I);
I = I - min(min(I));
I = I / max(max(I));
I = I < scaling; % to invert white & black

if ~isempty(fname)
    imwrite(I, [fname,'.png']);
end
end

