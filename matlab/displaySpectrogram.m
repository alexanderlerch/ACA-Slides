function displaySpectrogram()

    hFigureHandle = generateFigure(10.8,6.4);
    
    iStart  = 66000;
    iLength = 2048;
    
    [cPath, cName]  = fileparts(mfilename('fullpath'));
    cOutputFilePath = [cPath '/../graph/' strrep(cName, 'display', '')];
    
    % read sample data
    [x,fs] = audioread([cPath '/../audio/sax_example.wav']);
    x      = x/max(abs(x));

    [X,f,t] = spectrogram(x, hann(2048,'periodic'),1024,2048,fs);
    
    
    imagesc(t,f(1:floor(end/2))/1000,20*log10(abs(X(1:floor(end/2),:)))),colorbar
    c = colorbar;
    c.Label.String = '[dB]';
    set(gca,'YDir','normal');
    xlabel('t [s]')
    ylabel('f [kHz]')


    printFigure(hFigureHandle, cOutputFilePath)
end
