function animateCorrelation()

    bVideoOut     = false;
    hFigureHandle = generateFigure(12,5);
    
    [cPath, cName]  = fileparts(mfilename('fullpath'));
    if bVideoOut
        cOutputFilePath = [cPath '/../video/' strrep(cName, 'display', '')];
    else
        mkdir([cPath '/../graph/' cName '/']);
        cOutputFilePath = [cPath '/../graph/' cName '/' strrep(cName, 'animate', '')];
    end
 
    if bVideoOut
        writerObj = VideoWriter([cOutputFilePath '.mp4'],'MPEG-4');
        writerObj.FrameRate = 10;
        writerObj.Quality   = 100;
        open(writerObj);
    end

    t       = 0:499;
    rect    = [zeros(1,150) ones(1,50) zeros(1,300)];
    tri     = [zeros(1,250) linspace(0,1,50) linspace(1,0,50) zeros(1,150)];
    
    r = zeros(1,251);
    
    for (k = 0:-1:-250)
        subplot(211),plot(t,rect,t,[tri(-k+1:end),zeros(1,-k)])
        axis([t(1) t(end) 0 1.1])
        myarea = rect.*[tri(-k+1:end),zeros(1,-k)];
        hold on;area(t,myarea);hold off;
        legend('$x(t)$',['$y(t-' int2str(-k) ')$'],'mult.\ area')

        subplot(212)
        r(-k+1) = rect*[tri(-k+1:end),zeros(1,-k)]';
        plot(-250:0,fliplr(r))
        axis([-250 0 0 40])
        ylabel('$r_{xy}$')
        xlabel('$\eta$')

        if bVideoOut
            frame = getframe;
            writeVideo(writerObj,frame);
        else
            printFigure(hFigureHandle, [cOutputFilePath '-' num2str(-k,'%.3d')]); 
        end
    end    
    if bVideoOut
        close(writerObj); 
    end
end
