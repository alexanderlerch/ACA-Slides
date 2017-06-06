function animateStft()

    bVideoOut     = false;
    hFigureHandle = generateFigure(12,6);
    
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
 
    iFFTLength = 4096;
    iHopLength = 2048;

    % read sample data
    [x, fs] = audioread([cPath '/../audio/sax_example.wav'], [59601 59600+6*iHopLength]);
    x       = x./max(abs(x));
    tx      = linspace(0,length(x)/fs,length(x));

    [X,f,t] = spectrogram(x,hanning(iFFTLength),iHopLength,iFFTLength,fs);
    X       = abs(X);
    X       = 20*log10(abs(X(1:iFFTLength*.25,:))*2/iFFTLength);
    f       = f(1:iFFTLength*.25,:);

    w       = zeros(size(X,2), length(x));
    for (n=1:length(t))
        w(n,(n-1)*iHopLength+1:(n-1)*iHopLength+iFFTLength) = hanning(iFFTLength);
    end
    
     for (n=1:length(t))
        subplot(211),plot(tx,x,'Color', .7*ones(1,3)),grid on, axis([tx(1) tx(end) -1.1 1.1]),ylabel('$x(i)$');
        hold on; plot(tx,w(n,:)'.*x,'Color', 'black');hold off;
        hold on; plot(tx,w(n,:),'Color', [234, 170, 0]/256);hold off;
        subplot(212)
        waterfall(f,t,[X(:,1:n) ones(size(X,1),length(t)-n)*min(min(X))]'),view(75,-20);ylabel('$n$'),xlabel('$f$'),zlabel('$|X(k,n)|$')
        axis([f(1) f(end) t(1) t(end) -60 -10])
        set(gca,'XTickLabel',[],'YTickLabel',[],'ZTickLabel',[])
        set(gca,'Ytick',t)

        if bVideoOut
            frame = getframe;
            writeVideo(writerObj,frame);
        else
            printFigure(hFigureHandle, [cOutputFilePath '-' num2str(n,'%.3d')]); 
        end
end
    if bVideoOut
        close(writerObj); 
    end
end
