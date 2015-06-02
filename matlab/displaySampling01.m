function displaySampling01()

    hFigureHandle = generateFigure(10.8,5);
    
    iStart  = 66000;
    iLength = 1024;
    
    [cPath, cName]  = fileparts(mfilename('fullpath'));
    cOutputFilePath = [cPath '/../graph/' strrep(cName, 'display', '')];
 
    % read sample data
    [xt,fs] = audioread([cPath '/../audio/sax_example.wav'], [iStart iStart+iLength-1]);
    xt      = xt/max(abs(xt));
    tt      = linspace(0,(iLength-1)/fs,iLength);

    % pretend sampling the data
    downsampleFactor = 25;
    xs      = xt(1:downsampleFactor:end);
    ts      = 1:length(xs);
    
    subplot(211)
    plot(tt,xt)
    ylabel('x(t)')
    xlabel('t [s]')
    axis([tt(1) tt(end) -1.1 1.1])
    
    subplot(212)
    hl2 = stem(ts,xs,'k-','MarkerEdgeColor','k','MarkerFaceColor',[0 0 0],'MarkerSize',5);
    xlabel('i')
    ylabel('x(i)')
    axis([ts(1) length(xt)/downsampleFactor+1 -1.1 1.1])
    ax2 = axes('Parent',gcf,...
               'Position',get(gca,'Position'),...
               'XAxisLocation','top',...
               'YAxisLocation','left',...
               'Color','none',...
               'XColor','k','YColor','k');
    set(ax2,'YTick',[],'XTick',[]);

    hold on;
    hl1 = line(tt,xt,'Color','k','LineWidth',0.5,'Parent',ax2,'LineStyle','-.');
    axis([tt(1) tt(end) -1.1 1.1]),
    hold off;

    printFigure(hFigureHandle, cOutputFilePath)
end