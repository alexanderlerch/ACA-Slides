function displayCepstrum()

    hFigureHandle = generateFigure(12,4.5);
    
    iStart  = 66000;
    iLength = 4096;
    
    [cPath, cName]  = fileparts(mfilename('fullpath'));
    cOutputFilePath = [cPath '/../graph/' strrep(cName, 'display', '')];
 
    % read sample data
    [x, fs] = audioread([cPath '/../audio/sax_example.wav'], [iStart iStart+iLength-1]);
    t       = linspace(0,iLength/fs,iLength);
    x       = x/max(abs(x));

    X(1,:)  = abs(fft(hann(iLength).*x));
    X       = log(X(1,1:(iLength))*2/iLength);

    cepstrum= fftshift(real(ifft(X)));
    q       = (-1024:1024)/fs;
    
    X       = 20/log(10)*(X(1:iLength/2+1));
    f       = (0:iLength/2)/iLength*fs/1000;
        
    subplot(211)
    plot(f,X)
    xlabel('$f$ [kHz]')
    ylabel('$|X(k,n)|$ [dB]')
    axis([f(1) f(end) -100 0])
    
    subplot(212)
    plot(q,cepstrum(1024:3072))
    xlabel('Quefrency [s]')
    ylabel('$\hat{c}_x(i)$')
    axis([q(1) q(end) -.25 .5])

    printFigure(hFigureHandle, cOutputFilePath)
end