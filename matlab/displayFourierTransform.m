function displayFourierTransform()

    hFigureHandle = generateFigure(10.8,6);
    
    iStart  = 66000;
    iLength = 2048;
    
    [cPath, cName]  = fileparts(mfilename('fullpath'));
    cOutputFilePath = [cPath '/../graph/' strrep(cName, 'display', '')];
 
    % read sample data
    [x, fs] = audioread([cPath '/../audio/sax_example.wav'], [iStart iStart+iLength-1]);
    t       = linspace(0,(iLength-1)/fs,iLength);

    % generate plot data
    x       = x/max(abs(x));
    [X,f]   = generateSampleData(x,fs);
    
    subplot(221)
    plot(t,x)
    xlabel('t [s]');
    ylabel('x(t)');
    axis([t(1) t(end) -1 1]), grid on
    set(gca,'XTick',0:.01:t(end))
    set(gca,'XTicklabel','')
    
    subplot(222)
    plot(f,20*log10(abs(X(1:length(X)/2+1))),'LineWidth',.1)
    xlabel('f [kHz]')
    ylabel('|X(k,n)| [dB]')
    axis([f(1) f(end) -100 0])

    subplot(223)
    plot([-fliplr(f(2:end-1)) f], real(fftshift(X)),'LineWidth',.1)
    xlabel('f [kHz]')
    ylabel('\Re[X(k,n)]')
    axis([-f(end-1) f(end) -.35 .35])
    
    subplot(224)
    plot([-fliplr(f(2:end-1)) f], imag(fftshift(X)),'LineWidth',.1)
    xlabel('f [kHz]')
    ylabel('\Im[X(k,n)]')
    axis([-f(end-1) f(end) -.35 .35])
    
    printFigure(hFigureHandle, cOutputFilePath)
end

function [X,f]   = generateSampleData(x,fs)
    
    iFftLength  = length(x);
    
    f           = (0:(iFftLength/2))/iFftLength*fs/1000;
    X           = fft(hann(iFftLength).*x)*2/iFftLength;
end