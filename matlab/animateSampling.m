function animateSampling()

    bVideoOut     = false;
    hFigureHandle = generateFigure(12,5);
    
    [cPath, cName]  = fileparts(mfilename('fullpath'));
    if bVideoOut
        cOutputFilePath = [cPath '/../video/' strrep(cName, 'display', '')];
    else
        cOutputFilePath = [cPath '/../graph/' cName '/' strrep(cName, 'animate', '')];
    end
 
    if bVideoOut
        writerObj = VideoWriter([cOutputFilePath '.mp4'],'MPEG-4');
        writerObj.FrameRate = 10;
        writerObj.Quality   = 100;
        open(writerObj);
    end
    
    fs  = 300;
    i   = 1;
    for (fmax = 100:4:300)
        [X] = generateSampleData(fmax,fs);
        X   = [fliplr(X) X];
        
        plot((-length(X)/2+1:length(X)/2)/fs,X(1,:));

        hold on
        if (fs*.5 < fmax)
            H = area(linspace(.5,fmax/fs,fmax-.5*fs),X(1,length(X)/2+.5*fs+1:length(X)/2+fmax));
            set(H,'FaceColor', [.6 .6 .6]);
            H = area(linspace(-fmax/fs,-.5,fmax-.5*fs),fliplr(X(1,length(X)/2+.5*fs+1:length(X)/2+fmax)));
            set(H,'FaceColor', [.6 .6 .6]);
            
            
            H = area(linspace(1.5,1+fmax/fs,fmax-.5*fs),X(2,fs+.5*fs+1:fs+fmax));
            set(H,'FaceColor', [.6 .6 .6]);
            H = area(linspace(1-fmax/fs,.5,fmax-.5*fs),X(2,fs-fmax+1:fs*0.5));
            set(H,'FaceColor', 'r');
            H = area(linspace(-1-fmax/fs,-1.5,fmax-.5*fs),fliplr(X(2,fs+.5*fs+1:fs+fmax)));
            set(H,'FaceColor', [.6 .6 .6]);
            H = area(linspace(-.5,-1+fmax/fs,fmax-.5*fs),fliplr(X(2,fs-fmax+1:fs*0.5)));
            set(H,'FaceColor','r');

            H = area(linspace(2-fmax/fs,1.5,fmax-.5*fs),X(3,length(X)/2+2*fs-fmax+1:length(X)/2+1.5*fs));
            set(H,'FaceColor', [.6 .6 .6]);

        end
        plot((-length(X)/2+1:length(X)/2)/fs,X(2,:));%,'LineWidth', 2*iPlotLineWidth);
        plot((-length(X)/2+1:length(X)/2)/fs,X(3,:));%,'LineWidth', 2*iPlotLineWidth);
        set(gca,'XTick',[-2 -1 -.5 0 .5 1 2]);
        set(gca,'YTick',[0]);
        axis([-2 2 0.1 1.1]);
        ylabel('$|X(f)|$');
        xlabel('$f/f_\mathrm{S}$');
        hold off
        
        if bVideoOut
            frame = getframe;
            writeVideo(writerObj,frame);
        else
            printFigure(hFigureHandle, [cOutputFilePath '-' num2str(i,'%.2d')]); 
        end

        i=i+1;
        
    end

    if bVideoOut
        close(writerObj); 
    end
    
end

function [X] = generateSampleData(fmax,fs)

    X           = zeros(3,2*fs);
    X(1,1:fmax) = linspace(1,0,fmax);
    X(2,fs-fmax+1:fs+fmax) = [fliplr(X(1,1:fmax)), X(1,1:fmax)];
    X(3,:)      = fliplr(X(1,:));
end