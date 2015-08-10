function [x,t] = generateSineWave(fFreq, fLengthInS, fSampleRateInHz)

    [m n]   = size(fFreq);
    if (min(m,n)~=1)
        error('illegal frequency dimension')
    end
    if (m<n)
        fFreq   = fFreq';
    end
    
    t = linspace(0,fLengthInS-1/fSampleRateInHz,fSampleRateInHz*fLengthInS);
    
    x = sin(2*pi*fFreq*t);
end