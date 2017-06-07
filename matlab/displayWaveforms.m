function displayWaveforms()

    hFigureHandle = generateFigure(12,4);
    
    [cPath, cName]  = fileparts(mfilename('fullpath'));
    cOutputFilePath = [cPath '/../graph/' strrep(cName, 'display', '')];
 
    % read sample data
    cExamples   = char('pop', 'stringquartet', 'speech');
    for (i=1:size(cExamples,1))
        [x,fs]  = audioread([cPath '/../audio/excerpt_' deblank(cExamples(i,:)) '.mp3']);
        t       = linspace(0,(length(x)-1)/fs,length(x));
        
        subplot(1,3,i), plot(t,x)
        axis([t(1) t(end) -1 1])
        ylabel([ '$x(t)$ (' deblank(cExamples(i,:)) ')'])
        xlabel('$t$ [s]')
    end

    printFigure(hFigureHandle, cOutputFilePath)
end