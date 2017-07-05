function displayHarmonicsInPitchChroma()

    hFigureHandle = generateFigure(12,5);
    
    [cPath, cName]  = fileparts(mfilename('fullpath'));
    cOutputFilePath = [cPath '/../graph/' strrep(cName, 'display', '')];

    % generate data
    [f,A,pc] = generateSampleData();
    
    subplot(211),
    stem(f,A,'fill')
    axis([200 f(end) 0 1])
    xlabel('$f$ [Hz]')
    ylabel('$|X(f)|$')
    set(gca,'YTickLabels',[])

    subplot(212)
    bar(pc,'k')
    axis([.5 12.5 0 1])
    xlabel('Pitch Class')
    ylabel('$\nu$')
    set(gca,'XTick',1:12)
    set(gca,'XTickLabel',{'C','C#','D','D#','E','F','F#','G','G#','A','A#','B'})
    %set(gca,'YTick',0:.5:1)

    printFigure(hFigureHandle, cOutputFilePath)
end

function [f,A,pc] = generateSampleData()
    f_A4            = 440;
    f_F             = 220;
    numHarmonics    = 10;

    f = f_F*(1:numHarmonics);
    A = 1./(1:numHarmonics);

    pc = zeros(1,12);

    for (i = 1:numHarmonics)
        idx = mod(round(69 + 12*log2(f(i)/f_A4)), 12) + 1;
        pc(idx) = pc(idx) + A(i);
    end
    pc = pc/sum(pc);
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