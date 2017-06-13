function displayFreqResolution()

    hFigureHandle = generateFigure(8,5);
    
    iStart  = 66000;
    iLength = 4096;
    
    [cPath, cName]  = fileparts(mfilename('fullpath'));
    cOutputFilePath = [cPath '/../graph/' strrep(cName, 'display', '')];
 
    % read sample data
    [x, fs] = audioread([cPath '/../audio/sax_example.wav'], [iStart iStart+iLength-1]);
    x       = x/max(abs(x));
    
    resamplef = 8;
    fftlength = 256;
    X       = abs(fft(x(1:256).*hann(fftlength)));
    Xz      = abs(fft(x(1:256).*hann(fftlength),fftlength*resamplef));
    
    f       = linspace(0,fs,length(X));
    fi      = linspace(0,fs,length(Xz));
    Xi      = interp1(f,X,fi,'spline');

    range   = [1 15];
    subplot(211);
    plot(f,X,fi,Xz);
    axis([f(range(1,1)) f(range(1,2)) 0 45])    
    xlabel('$f$ [Hz]')
    ylabel('$|X_\mathrm{ZP}(f)|$')
    legend('normal','zeropad')
    subplot(212);
    plot(f,X,fi,Xi);
    axis([f(range(1,1)) f(range(1,2)) 0 45])    
    
    xlabel('$f$ [Hz]')
    ylabel('$|X_\mathrm{IP}(f)|$')
    legend('normal','interpol')
    
    printFigure(hFigureHandle, cOutputFilePath)
end