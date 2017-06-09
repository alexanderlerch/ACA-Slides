function displayLoudnessWeighting()

    hFigureHandle = generateFigure(12,4);
    
    [cPath, cName]  = fileparts(mfilename('fullpath'));
    cOutputFilePath = [cPath '/../graph/' strrep(cName, 'display', '')];
 
    % read sample data
    [f, H]  = generateSampleData();

    semilogx(f,H)
    
    legend ('BS.1770 MC','ITU-R BS.468','A Weighting','C Weighting','Z Weighting','Location','SouthEast');
    xlabel('$f$ [Hz]')
    ylabel('$|H(f)|$ [dB]')
    axis([50 16000 -25 15])

    printFigure(hFigureHandle, cOutputFilePath)
end

function [f,H] = generateSampleData()
    fs              = 48000;

    % bs 1770
    shlvcoeff_fir   = [1.5351249 -2.6916962 1.1983929];
    shlvcoeff_iir   = [1 -1.6906593 0.73248076];
    hpcoeff_fir     = [1.0000000 -2 1.0000000];
    hpcoeff_iir     = [1 -1.9900475 0.99007225];

    [H_shlv, f]     = freqz (shlvcoeff_fir, shlvcoeff_iir, 10000, fs);
    [H_hp, f]       = freqz (hpcoeff_fir, hpcoeff_iir, 10000, fs);
    H(:,1)          = 20*log10(abs(H_hp));
    H(:,2)          = 20*log10(abs(H_hp.*H_shlv));

    % a weighting
    H(:,3)          = 2+20*log10(abs((12200^2*f.^4)./ ((f.^2 + 20.6^2).*(f.^2 + 12200^2).*sqrt((f.^2+107.7^2).*(f.^2+737.9^2)))));
    % c weighting
    H(:,4)          = .06+20*log10(abs((12200^2*f.^2)./ ((f.^2 + 20.6^2).*(f.^2 + 12200^2))));

    % ccir
    fccir = [31.5
    63
    100
    200
    400
    800
    1000
    2000
    3150
    4000
    5000
    6300
    7100
    8000
    9000
    10000
    12500
    14000
    16000
    20000
    31500];

    dbccir = [-29.9
    -23.9
    -19.8
    -13.8
    -  7.8
    -  1.9
    0   
    +   5.6
    +   9.0
    + 10.5
    + 11.7
    + 12.2
    + 12.0
    + 11.4
    + 10.1
    +   8.1
    0   
    - 5.3
    -11.7
    -22.2
    -42.7];
    H(:,5) = interp1(fccir,dbccir,f,'spline');

    H(:,6) = 0;
    
    % omit BS1770
    H = H(:,2:end);
    
end