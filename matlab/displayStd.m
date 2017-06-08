function displayStd()

    hFigureHandle = generateFigure(8,6.8);
    
    iStart  = 1;
    iLength = 2^17;
    
    [cPath, cName]  = fileparts(mfilename('fullpath'));
    cOutputFilePath = [cPath '/../graph/' strrep(cName, 'display', '')];

    % read sample data
    [cPath, cName]  = fileparts(mfilename('fullpath'));
    [x,fs]  = audioread([cPath '/../audio/sax_example.wav'],[iStart iStart+iLength-1]);
    t       = linspace(0,(length(x)-1)/fs,length(x));
    x       = x/max(abs(x));
 

    subplot(211), 
    plot(t,x),
    axis([t(1) t(end) -1 1])
    xlabel('$t$ [s]')
    ylabel('$x(t)$')

    subplot(212)
    hist(x,100)
    h = findobj(gca,'Type','patch');
    h.FaceColor = [0.5 0.5 0.5];
    %h.EdgeColor = 'w';
    hold on;
    %vector([mean(x) mean(x)+std(x)], [.5 .5],'LineWidth', 2.5,'Color',[234/256 170/256 0])
    colorGtGold = [234, 170, 0]/256;
    annotation(hFigureHandle,'doublearrow',[0.44 0.52],[0.30 0.30],'Color',colorGtGold);
    hold off;
    text(0, 8000, sprintf('$\\sqrt{\\sigma_x} =%2.2f$',std(x)));
    xlabel('$x$')
    ylabel('$d_x(x)$')

    printFigure(hFigureHandle, cOutputFilePath)
    
end