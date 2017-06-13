function animatePhasor()

    bVideoOut     = false;
    hFigureHandle = generateFigure(8,5);
    
    [cPath, cName]  = fileparts(mfilename('fullpath'));
    if bVideoOut
        cOutputFilePath = [cPath '/../video/' strrep(cName, 'display', '')];
    else
        mkdir([cPath '/../graph/' cName '/']);
        cOutputFilePath = [cPath '/../graph/' cName '/' strrep(cName, 'animate', '')];
    end
 
    if bVideoOut
        writerObj = VideoWriter([cOutputFilePath '.mp4'],'MPEG-4');
        fs = 10;
        writerObj.Quality   = 100;
        open(writerObj);
        set(gca,'nextplot','replacechildren');
        set(gcf,'Renderer','zbuffer');
        
        fs = fs;
    else
        fs = 10;
    end

    iFrame = 0;
    iNumSeconds = 2;
    
    fFrequency  = 0.5;
    fRadius     = 1;
    for (k=1:2*iNumSeconds*fs)
        fCurrPhase  = 2*pi*fFrequency*(k-1)/fs;
        z           = fRadius*exp(i*fCurrPhase);
        dummyscale  = compass(1,0);
        set(dummyscale, 'Visible', 'off');
        hold on;
        compass(real(z),imag(z));
        hold off;
        xlabel('$\Re(X)$')
        ylabel('$\Im(X)$')
%         l=legend('$f = 0.5$Hz','$A = 1$','Location','northeastoutside');
%         l.TextColor = 'black';   
        zt = 1.4*exp(i*pi/4);
        text(real(zt),imag(zt),'$f = 0.5$Hz');
        text(real(zt),imag(zt)-.25,'$A = 1$');
        if bVideoOut
            frame = getframe;
            writeVideo(writerObj,frame);
        else
            printFigure(hFigureHandle, [cOutputFilePath '-' num2str(iFrame,'%.2d')]); 
            iFrame = iFrame + 1;
        end
    end
    fFrequency  = .5;
    fRadius     = .5;
    for (k=1:iNumSeconds*fs)
        fCurrPhase  = 2*pi*fFrequency*(k-1)/fs;
        z           = fRadius*exp(i*fCurrPhase);
        dummyscale  = compass(1,0);
        set(dummyscale, 'Visible', 'off');
        hold on;
        compass(real(z),imag(z));
        hold off;
        xlabel('$\Re(X)$')
        ylabel('$\Im(X)$')
%         l=legend('$f = 0.5$Hz','$A = 0.5$','Location','northeastoutside');
%         l.TextColor = 'black';                
        zt = 1.4*exp(i*pi/4);
        text(real(zt),imag(zt),'$f = 0.5$Hz');
        text(real(zt),imag(zt)-.25,'$A = 0.5$');
        
        if bVideoOut
            frame = getframe;
            writeVideo(writerObj,frame);
        else
            printFigure(hFigureHandle, [cOutputFilePath '-' num2str(iFrame,'%.2d')]); 
            iFrame = iFrame + 1;
        end
    end
    fFrequency  = 1;
    fRadius     = 1;
    for (k=1:iNumSeconds*fs+1)
        fCurrPhase  = 2*pi*fFrequency*(k-1)/fs;
        z           = fRadius*exp(i*fCurrPhase);
        dummyscale  = compass(1,0);
        set(dummyscale, 'Visible', 'off');
        hold on;
        compass(real(z),imag(z));
        hold off;
        xlabel('$\Re(X)$')
        ylabel('$\Im(X)$')
%         l=legend('$f = 1$Hz','$A = 1$','Location','northeastoutside');
%         l.TextColor = 'black';                
        zt = 1.4*exp(i*pi/4);
        text(real(zt),imag(zt),'$f = 1$Hz');
        text(real(zt),imag(zt)-.25,'$A = 1$');
        
        if bVideoOut
            frame = getframe;
            writeVideo(writerObj,frame);
        else
            printFigure(hFigureHandle, [cOutputFilePath '-' num2str(iFrame,'%.2d')]); 
            iFrame = iFrame + 1;
        end
    end

    if bVideoOut
        close(writerObj); 
    end
    
end
