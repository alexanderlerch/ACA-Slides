function displayAcfOfFft()

    hFigureHandle = generateFigure(12,5);
    
    iStart  = 66000;
    iLength = 4096;
    
    [cPath, cName]  = fileparts(mfilename('fullpath'));
    cOutputFilePath = [cPath '/../graph/' strrep(cName, 'display', '')];
 
    % read sample data
    [x, fs] = audioread([cPath '/../audio/sax_example.wav'], [iStart iStart+iLength-1]);
    t       = linspace(0,iLength/fs,iLength);
    x       = x/max(abs(x));

    X(1,:)  = (abs(fft(hann(iLength).*x))*2/iLength).^2;

    P       = cconv(X,X,iLength);

    X       = 10*log10(X(1:iLength/2+1));
    f       = (0:iLength/2)/iLength*fs/1000;
        
    subplot(211)
    plot(f,X)
    xlabel('$f$ [kHz]')
    ylabel('$|X(k,n)|$ [dB]')
    axis([f(1) f(end) -100 0])
    
    subplot(212)
    plot(f,P(1:iLength/2+1))
    xlabel('$\eta_f$')
    ylabel('$r_\mathrm{XX}(\eta)$')
    axis([f(1) f(end) 0 .03])

    printFigure(hFigureHandle, cOutputFilePath)
end