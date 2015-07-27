function displayEqualLoudnessContours()

    hFigureHandle = generateFigure(10.8,8);
    
    [cPath, cName]  = fileparts(mfilename('fullpath'));
    cOutputFilePath = [cPath '/../graph/' strrep(cName, 'display', '')];

    % tables from iso-226
    fFreq = [20 25 31.5 40 50 63 80 100 125 160 200 250 315 400 ...
        500 630 800 1000 1250 1600 2000 2500 3150 4000 5000 6300 ...
        8000 10000 12500];

    fAlpha = [0.532 0.506 0.480 0.455 0.432 0.409 0.387 0.367 0.349 ...
        0.330 0.315 0.301 0.288 0.276 0.267 0.259 0.253 0.250 0.246 ...
        0.244 0.243 0.243 0.243 0.242 0.242 0.245 0.254 0.271 0.301];

    Lu = [-31.6 -27.2 -23.0 -19.1 -15.9 -13.0 -10.3 -8.1 -6.2 -4.5 ... 
        -3.1 -2.0  -1.1  -0.4   0.0   0.3   0.5   0.0 -2.7 -4.1 ...
        -1.0  1.7 2.5   1.2  -2.1  -7.1 -11.2 -10.7  -3.1];

    fAth = [ 78.5  68.7  59.5  51.1  44.0  37.5  31.5  26.5  22.1 ...  
        17.9  14.4 11.4   8.6   6.2   4.4   3.0   2.2   2.4   3.5 ...  
        1.7  -1.3  -4.2 -6.0  -5.4  -1.5   6.0  12.6  13.9  12.3];

    fPhon2Plot = [0 20 40 60 80 90];
    
    fLevel = zeros(length(fPhon2Plot), length(fFreq));
    fLogFreq = logspace(log10(min(fFreq)),log10(max(fFreq)),1000); 
    fLevelIntp = zeros(length(fPhon2Plot), length(fLogFreq));
    
    for (i = 1:length(fPhon2Plot))
        A_f = 4.47e-3 *(10.^(0.025*fPhon2Plot(i))-1.15) + (0.4*10.^(0.1*(fAth+Lu-90))).^fAlpha;
        fLevel(i,:) = 10./fAlpha.*log10(A_f)-Lu+94;
        fLevelIntp(i,:) = interp1(fFreq,fLevel(i,:),fLogFreq,'PCHIP');
    end
    
    
    % plot data
    semilogx (fLogFreq, fLevelIntp);

    % data formatting
    axis([fLogFreq(1) fLogFreq(end) -10 120]);

    for (i = 1:length(fPhon2Plot))
        text(1000, fPhon2Plot(i)+(3+i), [num2str(fPhon2Plot(i)) ' phon'])
    end

    xlabel('$f$ [Hz]');
    ylabel('$SPL$ [dB]');

    printFigure(hFigureHandle, cOutputFilePath)

end
