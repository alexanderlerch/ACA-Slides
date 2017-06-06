function displayBlocking()

    hFigureHandle = generateFigure(11,3.8);
    
    [cPath, cName]  = fileparts(mfilename('fullpath'));
    cOutputFilePath = [cPath '/../graph/' strrep(cName, 'display', '')];
 
    % read sample data
    [x,fs]  = audioread([cPath '/../audio/sax_example.mp3'], [4501 4500+5*2048]);
    t       = linspace(0,(length(x)-1)/fs,length(x));

    subplot(211), plot(t,x)
    axis([t(1) t(end) -1 1])
    ylabel('$x(t)$')
    set(gca,'XTickLabel',[]);
    
    K = 4096;
    H = 2048;
    numBlocks = length(x)/H-1; %this is only for integer division
    xb = zeros (numBlocks, length(x));
    for (n = 1:numBlocks)
        i_s = (n-1)*H+1;
        i_e = i_s + K-1;
        xb(n,i_s:i_e) = x(i_s:i_e);
        subplot(8,1,4+n)
        plot(t,xb(n,:))
        axis([t(1) t(end) -1 1])
        set(gca,'XTickLabel',[]);
        set(gca,'YTickLabel',[]);
    
    end
        
    
    
    
    xlabel('$t$ [s]')

    printFigure(hFigureHandle, cOutputFilePath)
end