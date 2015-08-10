function animatePhasor()

   
    [cPath, cName]  = fileparts(mfilename('fullpath'));
    cOutputFilePath = [cPath '/../video/' strrep(cName, 'display', '')];
 
    writerObj = VideoWriter([cOutputFilePath '.mp4'],'MPEG-4');
    writerObj.FrameRate = 24;
    writerObj.Quality   = 90;
    open(writerObj);

    hFigureHandle = generateFigure(10.8,6.45);
    set(gca,'nextplot','replacechildren');
    set(gcf,'Renderer','zbuffer');

    iNumSeconds = 2;
    
    fFrequency  = 0.5;
    fRadius     = 1;
    for (k=1:2*iNumSeconds*writerObj.FrameRate)
        fCurrPhase  = 2*pi*fFrequency*(k-1)/writerObj.FrameRate;
        z           = fRadius*exp(i*fCurrPhase);
        dummyscale  = compass(1,0);
        set(dummyscale, 'Visible', 'off');
        hold on;
        compass(real(z),imag(z));
        hold off;
        xlabel('$\Re(X)$')
        ylabel('$\Im(X)$')
        legend('f = 0.5Hz','A = 1','Location','northeastoutside');
                
        frame = getframe(hFigureHandle);
        writeVideo(writerObj,frame);
    end
    fFrequency  = .5;
    fRadius     = .5;
    for (k=1:iNumSeconds*writerObj.FrameRate)
        fCurrPhase  = 2*pi*fFrequency*(k-1)/writerObj.FrameRate;
        z           = fRadius*exp(i*fCurrPhase);
        dummyscale  = compass(1,0);
        set(dummyscale, 'Visible', 'off');
        hold on;
        compass(real(z),imag(z));
        hold off;
        xlabel('$\Re(X)$')
        ylabel('$\Im(X)$')
        legend('f = 0.5Hz','A = 0.5','Location','northeastoutside');
        
        frame = getframe(hFigureHandle);
        writeVideo(writerObj,frame);
    end
    fFrequency  = 1;
    fRadius     = 1;
    for (k=1:iNumSeconds*writerObj.FrameRate+1)
        fCurrPhase  = 2*pi*fFrequency*(k-1)/writerObj.FrameRate;
        z           = fRadius*exp(i*fCurrPhase);
        dummyscale  = compass(1,0);
        set(dummyscale, 'Visible', 'off');
        hold on;
        compass(real(z),imag(z));
        hold off;
        xlabel('$\Re(X)$')
        ylabel('$\Im(X)$')
        legend('f = 1Hz','A = 1','Location','northeastoutside');
        
        frame = getframe(hFigureHandle);
        writeVideo(writerObj,frame);
    end
    
    close(writerObj);
    
end
