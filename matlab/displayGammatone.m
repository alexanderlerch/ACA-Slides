function displayGammatone()

    hFigureHandle = generateFigure(10.8,6.4);
    
    [cPath, cName]  = fileparts(mfilename('fullpath'));
    cOutputFilePath = [cPath '/../graph/' strrep(cName, 'display', '')];

    % generate sample data
    [t,h, f,H] = generateSampleData();
    
    subplot(211),
    plot(t,h)

    xlabel('t [s]')
    ylabel('h(t)')
    legend('f_c=1kHz')
    
    subplot(212),
    plot(f,H),
    axis([f(1) 16 -50 0])
    xlabel('f [kHz]')
    ylabel('|H(f)| [dB]')


    printFigure(hFigureHandle, cOutputFilePath)
end

function [t,h, f,H] = generateSampleData()
    fc  = 1000;
    b   = 125;
    O   = 4;
    t   = linspace (0,0.015,4096);
    
    h   = t.^(O-1).*exp(-2*pi*b*t).* cos(2*pi*fc*t);
    h   = h/max(abs(h));
    
    fs          = 48000;
    iFFTLength  = 2^14;
    i           = 1;
 
    t2           = linspace (0,1,iFFTLength);
    
    for (i = 1:20)
       fc(i)    = 228.7*exp((2*i/9.26)-1);
       b(i)     = fc(i)/4;
       h2        = t2.^(O-1).*exp(-2*pi*b(i)*t2).* cos(2*pi*fc(i)*t2);
       H(i,:)   = abs(fft(h2));
       H(i,:)   = 20*log10(H(i,:)/max(H(i,:)));
    end

%     fCoefs  = MakeERBFilters(iSampleRate,iNumOfBands,fLowFreq);
%     H       = ERBFilterBank([1 zeros(1,iFFTLength-1)], fCoefs);
%     H       = 20*log10(abs(fft(H')));
    H       = H(:,1:(iFFTLength/2))';
    f       = (0:(iFFTLength/2-1))*fs/iFFTLength/1000;
    
end
