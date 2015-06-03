function [xq] = quantizeAudio(x, nbit)
    x(x<-1) = -1;
    xq      = min(2^nbit-1,round((x + 1)*2^(nbit-1)));
    xq      = xq*2^(-nbit+1)-1;
end