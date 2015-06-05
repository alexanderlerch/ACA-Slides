function displaySpectralWindows()

    hFigureHandle = generateFigure(10.8,6);
    
    iStart  = 66000;
    iLength = 2048;
    
    [cPath, cName]  = fileparts(mfilename('fullpath'));
    cOutputFilePath = [cPath '/../graph/' strrep(cName, 'display', '')];

    % generate plot data
    [t,w,f,W]   = generateSampleData();
    
    subplot(221)
    plot(t,w(1,:),t,w(3,:),t,w(4,:),t,w(6,:))
    axis([t(1)-10 t(end)+10 0 1.05])
    ylabel('w(i)');

    subplot(222)
    plot(f,W(:,1),f,W(:,3),f,W(:,4),f,W(:,6))
    axis([f(1) f(end) -60 5])
    ylabel('|W(j\omega)|');

    lh = legend('$w_\mathrm{R}$','$w_\mathrm{C}$','$w_\mathrm{H}$','$w_\mathrm{B}$','Location','SouthEast');
    set(lh, 'FontSize', 6, 'Interpreter','latex')
    
    subplot(223)
    plot(t,w(5,:),t,w(8,:),t,w(7,:),t,w(2,:))
    axis([t(1)-10 t(end)+10 0 1.05])
    ylabel('w(i)');
    xlabel('i')
    
    subplot(224)
    plot(f,W(:,5),f,W(:,8),f,W(:,7),f,W(:,2))
    axis([f(1) f(end) -60 5])
    ylabel('|W(j\omega)|');
    xlabel('\omega/\omega_S')

    lh = legend('$w_\mathrm{Hm}$','$w_\mathrm{AB}$','$w_\mathrm{BH}$','$w_\mathrm{T}$','Location','SouthEast');
    set(lh, 'FontSize', 6, 'Interpreter','latex')

    printFigure(hFigureHandle, cOutputFilePath)
end

function [t,w,f,W]   = generateSampleData()
    
    iRatio          = 32;
    iWindowLength   = 1024;
    iFFTLength      = 16384;
    f       = (0:(iFFTLength-1)/iRatio)/iFFTLength;%*pi/2;
    w(1,:)  = [ones(1,iWindowLength) zeros(1,iFFTLength-iWindowLength)]; %rect
    w(2,:)  = [bartlett(iWindowLength)' zeros(1,iFFTLength-iWindowLength)]; %tri :(0:(iWindowLength/2-1))*2/iWindowLength fliplr(1:(iWindowLength/2))*2/iWindowLength
    w(3,:)  = [sin(pi/iWindowLength*(0:(iWindowLength-1))) zeros(1,iFFTLength-iWindowLength)]; %tri
    w(4,:)  = [hanning(iWindowLength,'symmetric')' zeros(1,iFFTLength-iWindowLength)]; %hann
    w(5,:)  = [hamming(iWindowLength,'symmetric')' zeros(1,iFFTLength-iWindowLength)]; %hamming
    w(6,:)  = [blackman(iWindowLength,'symmetric')' zeros(1,iFFTLength-iWindowLength)]; %blackman
    w(7,:)  = [blackmanharris(iWindowLength)' zeros(1,iFFTLength-iWindowLength)]; %blackmanharris
    w(8,:)  = [sin(pi/iWindowLength*(0:(iWindowLength-1))).^4 zeros(1,iFFTLength-iWindowLength)]; %altblackman
    
    W       = 20*log10(abs(fft(w'))/iWindowLength);
    W       = W(1:length(f),:);
    %Win = Win-repmat(max(Win,[],1),length(x),1);
    
    w       = w(:,1:iWindowLength);
    t       = (1:iWindowLength)-iWindowLength/2;
end