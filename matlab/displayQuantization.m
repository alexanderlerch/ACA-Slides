function displaySampling01()

    hFigureHandle = generateFigure(10.8,5);
    
    iStart      = 66000;
    iLength     = 768;
    iWordLength = 4;
    
    [cPath, cName]  = fileparts(mfilename('fullpath'));
    cOutputFilePath = [cPath '/../graph/' strrep(cName, 'display', '')];
 
    % generate sample data
    [xt,fs] = audioread([cPath '/../audio/sax_example.wav'], [iStart iStart+iLength-1]);
    xt      = xt/max(abs(xt));
    tt      = linspace(0,(iLength-1)/fs,iLength);

    % quantize the data
    xq      = quantizeAudio(xt, iWordLength);
    
    subplot(211)
    plot(tt,xt)
    ylabel('x(t)')
    axis([tt(1) tt(end) -1.1 1.1])
    
    subplot(212)
    stairs(tt,xq,'LineWidth',1.1)
    xlabel('t [s]')
    ylabel('x_Q(t)')
    axis([tt(1) tt(end) -1.1 1.1])

    printFigure(hFigureHandle, cOutputFilePath)
end