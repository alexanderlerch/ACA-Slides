function displayPeriodicRandom()

    hFigureHandle = generateFigure(10.8,5);
    
    iStart  = 66000;
    iLength = 1024;
    
    [cPath, cName]  = fileparts(mfilename('fullpath'));
    cOutputFilePath = [cPath '/../graph/' strrep(cName, 'display', '')];
 
    % read sample data
    [xp,fs] = audioread([cPath '/../audio/sax_example.wav'], [iStart iStart+iLength-1]);
    t       = linspace(0,iLength/fs,iLength);

    % generate sample data
    xr      = .125*randn(size(xp));
    
    subplot(211)
    plot(t,xp)
    ylabel('x_{periodic}(t)')
    axis([t(1) t(end) floor(-10*max(abs(xp)))/10 ceil(10*max(abs(xp)))/10])
    
    subplot(212)
    plot(t,xr)
    xlabel('t [s]')
    ylabel('x_{random}(t)')
    axis([t(1) t(end) floor(-10*max(abs(xr)))/10 ceil(10*max(abs(xr)))/10])

    colorGtGold = [234, 170, 0]/256;
    annotation(hFigureHandle,'doublearrow',[0.40 0.50],[0.90 0.90],'Color',colorGtGold);
    annotation(hFigureHandle,'textbox',[0.42 0.83 0.026 0.067],'Color',colorGtGold,'EdgeColor','none','String',{'T_0'});
    
    printFigure(hFigureHandle, cOutputFilePath)
end