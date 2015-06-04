function animateCorrelation()

    hFigureHandle = generateFigure(10.8,6.45);
    
    [cPath, cName]  = fileparts(mfilename('fullpath'));
    cOutputFilePath = [cPath '/../video/' strrep(cName, 'display', '')];
 
    writerObj = VideoWriter([cOutputFilePath '.mp4'],'MPEG-4');
    writerObj.FrameRate = 12;
    writerObj.Quality   = 90;
    open(writerObj);
    set(gca,'nextplot','replacechildren');
    set(gcf,'Renderer','zbuffer');

    t       = 0:499;
    rect    = [zeros(1,150) ones(1,50) zeros(1,300)];
    tri     = [zeros(1,250) linspace(0,1,50) linspace(1,0,50) zeros(1,150)];
    
    r = zeros(1,251);
    
    for (k = 0:-1:-250)
        subplot(211),plot(t,rect,t,[tri(-k+1:end),zeros(1,-k)])
        axis([t(1) t(end) 0 1.1])
        legend('x(t)',['y(t-' int2str(-k) ')'])
        myarea = rect.*[tri(-k+1:end),zeros(1,-k)];
        hold on;area(t,myarea);hold off;

        subplot(212)
        r(-k+1) = rect*[tri(-k+1:end),zeros(1,-k)]';
        plot(-250:0,fliplr(r))
        axis([-250 0 0 40])
        ylabel('r_{xy}')
        xlabel('\eta')

        frame = getframe(hFigureHandle);
        writeVideo(writerObj,frame);
    end    
    close(writerObj);
    
end
