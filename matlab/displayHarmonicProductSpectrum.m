function displayHarmonicProductSpectrum()
    
    if(exist('ComputePitch') ~=2)
        error('Please add the ACA scripts (https://github.com/alexanderlerch/ACA-Code) to your path!');
    end

    hFigureHandle = generateFigure(10.8,5);
    
    iStart  = 66000;
    iLength = 4096;
    iOrder  = 4;
    
    [cPath, cName]  = fileparts(mfilename('fullpath'));
    cOutputFilePath = [cPath '/../graph/' strrep(cName, 'display', '')];
 
    % read sample data
    [x, fs] = audioread([cPath '/../audio/sax_example.wav'], [iStart iStart+iLength-1]);
    x       = x/max(abs(x));
    f       = (0:iLength/2)/iLength*fs/1000;

    X(1,:)  = abs(fft(hann(iLength).*x))*2/iLength;
    X       = X(1,1:end/2+1).^2;

    P       = X(1,:);
    for (r = 2:iOrder)
        X(r,:)  = [X(1,1:r:end) zeros(1,iLength/2+1-length(X(1,1:r:end)))];
        P       = P.*X(r,:);
    end
    X   = 10*log10(X);
    P   = 10*log10(P);
    
    subplot(211)
   	semilogx(f,flipud(X)');
    axis([.1 f(end) -100 0])

    legend('j=1','j=2','j=3','j=4')
    ylabel('$|X(j\cdot k,n)|$ [dB]')
   
    subplot(212)
    semilogx(f,P)
    
    axis([.1 f(end) -210 -90])

    xlabel('$f$ [kHz]')
    ylabel('$|X_\mathrm{HPS}(k,n)|$ [dB]')

    printFigure(hFigureHandle, cOutputFilePath)
end