function animateConvolution()

    bVideoOut     = false;
    hFigureHandle = generateFigure(12,6.8);
    
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

    t       = (0:649)-326;
    rect    = [zeros(1,300) ones(1,50) zeros(1,300)];
    tri     = [zeros(1,650)];
    for (k=1:250)
        tri(400+k) = sqrt(1/k);
    end
    
    r = zeros(1,601);
    tritmp = fliplr(tri);
    for (k = 0:600)
        subplot(311),plot(t,rect,t,tri,'LineWidth',2),grid on,axis([t(1) t(end) 0 1.1])
        legend('$x(t)$','$h(t)$')
        subplot(312),plot(t,rect,t,[zeros(1,k) tritmp(1:end-k)],'LineWidth',2),grid on,axis([t(1) t(end) 0 1.1])
        myarea = rect.*[zeros(1,k) tritmp(1:end-k)];
        hold on;area(t,myarea);hold off;
        legend('$x(\tau)$',['$h(-\tau+' int2str(k) ')$'],'mult.\ area')

        subplot(313)
        r(k+1) = rect*[zeros(1,k) tritmp(1:end-k)]';
        plot(r,'LineWidth',2),grid on,ylabel('$y(t)$'),xlabel('$t$'),axis([0 601 0 15])

        if bVideoOut
            frame = getframe;
            writeVideo(writerObj,frame);
        else
            printFigure(hFigureHandle, [cOutputFilePath '-' num2str(k,'%.3d')]); 
        end
    end    
    if bVideoOut
        close(writerObj); 
    end
    
end
