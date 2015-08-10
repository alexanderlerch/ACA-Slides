function [f_I] = computeInstantaneousFreq(X,iHop,fs)
    phi         = angle(X);

    omega       = pi*iHop/size(X,2)*(0:size(X,2)-1);
    deltaphi    = omega + princarg(phi(2,:)-phi(1,:)-omega);
    f_I         = deltaphi/iHop/(2*pi)*fs;
end

function phase = princarg(phi)
    phase = mod(phi + pi,-2*pi) + pi;
end