function displayKarjalainen()

    hFigureHandle = generateFigure(10.8,7);
    
    iStart  = 66000;
    iLength = 4096;
    
    [cPath, cName]  = fileparts(mfilename('fullpath'));
    cOutputFilePath = [cPath '/../graph/' strrep(cName, 'display', '')];
 
    % generate data
    [f,X,eta,r] = generateSampleData([cPath '/../audio/sax_example.wav'], [iStart iStart+iLength-1]);

    subplot(311)
    semilogx(f,X)
    xlabel('$f$ [kHz]')
    ylabel('$|X(k,n)|$ [dB]')
    axis([f(12) f(end) -100 0])
    
    subplot(312)
    plot(eta,r(2,:))
    xlabel('$\eta$')
    ylabel('$r_{HWR(x)HWR(x)}(\eta)$')
    axis([eta(1) eta(end) 0 1])
    
    subplot(313)
    plot(eta,r(3,:))
    xlabel('$\eta$')
    ylabel('$r_\mathrm{H}(\eta)$')
    axis([eta(1) eta(end) 0 1])

    printFigure(hFigureHandle, cOutputFilePath)
end

function [f,X,eta,r] = generateSampleData(cFilePath, iExcerptIdx)
    [x, fs] = audioread(cFilePath, iExcerptIdx);
    
    iLength = length(x);
    iOrder  = 6;
    eta     = linspace(0, (iLength-1)/fs,iLength);
    x       = x/max(abs(x));

    X(1,:)  = abs(fft(hann(iLength).*x));
    X       = 20*log10(X(1,1:(iLength/2+1))*2/iLength);
    f       = fs/iLength*(0:length(X)-1)*1e-3;
    
    dummy   = xcorr(x,'coeff');
    r(1,:)  = dummy(iLength:end);
    
    dummy   = xcorr(HWR(x),'coeff');
    r(2,:)  = dummy(iLength:end);
    
    r(2,1:find(r(2,:)<=0,1))  = 0;
    r(3,:)  = r(2,:);

for (i = 2:iOrder)
    dummy   = interp1(0:(length(r)-1),r(2,:), (0:(i*length(r)-1))/i);
    r(3,:)  = HWR(r(3,:)-HWR(dummy(1:length(r))));
end
    
end

function out = HWR(x)
    out = (x + abs(x))*.5;
end