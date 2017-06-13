function displayNmfTemplates()

    hFigureHandle = generateFigure(12,6);
    
    [cPath, cName]  = fileparts(mfilename('fullpath'));
    cOutputFilePath = [cPath '/../graph/' strrep(cName, 'display', '')];
 
    % generate sample data
    [xt,fs] = audioread([cPath '/../audio/4notes.mp3']);
    xt      = xt/max(abs(xt));
    tt      = linspace(0,(length(xt)-1)/fs,length(xt));

    % compute spectra
    [X,f,t] = spectrogram(xt, 4096,2048,4096,fs);
    
    [W,H,D] = nnmf(abs(X)*2/4096,4); 
 
  
    subplot(181)
    plot(f,W(:,1))
    axis([f(1) f(512) 0 .5 ])
    view(270,90)
    set(gca,'XTickLabel',[])
    set(gca,'YTickLabel',[])
  
    subplot(182)
    plot(f,W(:,2))
    axis([f(1) f(512) 0 .5 ])
    view(270,90)
    set(gca,'XTickLabel',[])
    set(gca,'YTickLabel',[])
  
    subplot(183)
    plot(f,W(:,3))
    axis([f(1) f(512) 0 .5 ])
    view(270,90)
    set(gca,'XTickLabel',[])
    set(gca,'YTickLabel',[])
  
    subplot(184)
    plot(f,W(:,4))
    axis([f(1) f(512) 0 .5 ])
    view(270,90)
    set(gca,'XTickLabel',[])
    set(gca,'YTickLabel',[])
    
    subplot(422)
    plot(t,H(1,:))
    axis([t(1) t(end) 0 .5])
    set(gca,'XTickLabel',[])
    set(gca,'YTickLabel',[])
    
    subplot(424)
    plot(t,H(2,:))
    axis([t(1) t(end) 0 .5])
    set(gca,'XTickLabel',[])
    set(gca,'YTickLabel',[])
    
    subplot(426)
    plot(t,H(3,:))
    axis([t(1) t(end) 0 .5])
    set(gca,'XTickLabel',[])
    set(gca,'YTickLabel',[])
    
    subplot(428)
    plot(t,H(4,:))
    axis([t(1) t(end) 0 .5])
    set(gca,'XTickLabel',[])
    set(gca,'YTickLabel',[])
    
    
    printFigure(hFigureHandle, cOutputFilePath)
end