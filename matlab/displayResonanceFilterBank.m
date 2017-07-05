function displayResonanceFilterBank()

    hFigureHandle = generateFigure(12,5);
    
    [cPath, cName]  = fileparts(mfilename('fullpath'));
    cOutputFilePath = [cPath '/../graph/' strrep(cName, 'display', '')];

    % generate data
    [f,H] = generateSampleData();

    plot(f,H)
    axis([0 1800 -40 0])
    xlabel('$f$ [Hz]')
    ylabel('$|H(f)|$ [dB]')

    printFigure(hFigureHandle, cOutputFilePath)
end

function [f,H] = generateSampleData()
    fs              = 8192;
    iNumFilters     = 48;
    freq            = zeros(1,iNumFilters);
    freq(1)         = 110;
    fResonatorBandwidth = -pi * 1.35 / fs; 
    fPitchFactor    = 2^(1/12);
    for (i = 1:iNumFilters)
        freq(i)             = freq(1)* 2^((i-1)/12);
        fResonatorRadius    = exp (fResonatorBandwidth* 2^((i-1)/12));
        [b,a] = calcResFilterCoeff (freq(i), fResonatorRadius, fs);
        [W,f] = freqz(b,a,16384,fs);
        H(i,:) = abs(W);

        H(i,:) = H(i,:)/log2((10*i)/12); % just example weighting for plot
        H(i,:) = 20*log10(abs(H(i,:)));
    end
end

function [b,a] = calcResFilterCoeff (fResFreq, fRadius, fSampleRate)

    fAlpha      = 2*pi * fResFreq / fSampleRate;
    fCosAlpha   = cos(fAlpha);

    coeff(1)    = (-2.0 * abs(fRadius) * fCosAlpha);  % IIR1
    coeff(2)    = (fRadius^2);                                % IIR2
    coeff(3)    = (coeff(1) + fCosAlpha*(1+coeff(2)))^2;
    coeff(3)    = coeff(3) + ((coeff(2)-1) * sin(fAlpha))^2;
    coeff(3)    = sqrt(coeff(3));                  % scale to 0dB

    b = coeff(3);
    a = [1 coeff(1) coeff(2)];
end