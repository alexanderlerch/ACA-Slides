function displayPitchChromaGrouping()

    hFigureHandle = generateFigure(12,6.8);
    
    if(exist('ComputeFeature') ~=2)
        error('Please add the ACA scripts (https://github.com/alexanderlerch/ACA-Code) to your path!');
    end
    [cPath, cName]  = fileparts(mfilename('fullpath'));
    cOutputFilePath = [cPath '/../graph/' strrep(cName, 'display', '')];
    iStart  = 16384;
    iLength = 4096;
 
    % generate data
    [px,X,pw,H,ptick] = generateSampleData([cPath '/../audio/sax_example.wav'], [iStart iStart+iLength-1]);

    [AX,h1,h2] = plotyy(px,X,pw,H);
    axis(AX(1),[ptick(1) ptick(end) 0.01 1.02])
    axis(AX(2),[ptick(1) ptick(end) 0.01 1.02])

    set(AX(2),'YTick',[]);
    set(AX(1),'XTick',ptick)
    set(get(AX(1),'Ylabel'),'String','$|X(k,n)|$');
    set(get(AX(2),'Ylabel'),'String','$w_\mathrm{E}$');
    xlabel('MIDI Pitch')

    printFigure(hFigureHandle, cOutputFilePath)
end

function [px,X,pw,W,ptick] = generateSampleData(cFilePath, aiIdx)
    fA4     = 440;

    [x,fs]  = audioread(cFilePath, aiIdx);
    x       = x/max(abs(x));
    
    X       = (abs(fft(hann(length(x)).*x)));
    X       = X(1:length(x)/2+1);
    px       = 69+12*log2(linspace(0, fs/2, length(x)/2+1)/fA4);
    X       = X/max(X);

    % midi pitch
    w = [61.5 62.5
        73.5 74.5
        85.5 86.5
        97.5 98.5] + 2;

    %frequency
    %w = fA4 * 2.^((w-69)/12);

    % fft bin
    %w = round(w/fs*length(x));
    
    tickbase = [60 62  65 67 69 ];
    ptick   = [];
    for (i = 1:size(w,1))
        ptick = [ptick tickbase+(i-1)*12] ;
    end

    pw = 60:0.1:round(ptick(end));
    W  = zeros(size(pw));

    for (i = 1:size(w,1))
        W ((w(i,1)-pw(1))*10:(w(i,2)-pw(1))*10) = 1;
    end
end