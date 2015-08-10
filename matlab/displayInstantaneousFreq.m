function displayInstantaneousFreq()

    hFigureHandle = generateFigure(10.8,7);
    
    [cPath, cName]  = fileparts(mfilename('fullpath'));
    cOutputFilePath = [cPath '/../graph/' strrep(cName, 'display', '')];
 
    % read sample data
    [f,X,f_I, cLegend]  = generateSampleData();

    subplot(211)
    plot(f,X(1,:));
    axis([f(1) f(end) 0 0.5])
    xlabel('$f [Hz]$');
    ylabel('$|X(f)|$');
    
    subplot(212)
    plot(0:length(f_I)-1,f_I);
    axis([0 length(f_I)+1 min(f_I) max(f_I)])

    xlabel('$k$');
    ylabel('$|f_I(k)|$');
    lh = legend(cLegend);
    set(lh,'Location','SouthEast','Interpreter','latex')

    printFigure(hFigureHandle, cOutputFilePath)
end

function [f,X,f_I, cLegend] = generateSampleData()

    iFftLength  = 1024;
    fs          = 48000;
    iHop        = 256;
    fFreqRes    = fs/iFftLength;
    fLengthInS  = (iFftLength + iHop)/fs;
    f           = linspace(0,fs/2,iFftLength/2+1);
    
    bins        = iFftLength./[32 8 4];
    fFreq       = fFreqRes*(bins + [.5 .25 0]);
    
    [x,t]   = generateSineWave(fFreq, fLengthInS, fs);
    %x       = 0.25*x;
    
    X(1,:)  = fft(sum(x(:,1:iFftLength),1).*hann(iFftLength)')*2/iFftLength;
    X(2,:)  = fft(sum(x(:,iHop+1:iFftLength+iHop),1).*hann(iFftLength)')*2/iFftLength;
%     X(1,:)  = fft(sum(x(:,1:iFftLength/4),1),iFftLength)*2/iFftLength;
%     X(2,:)  = fft(sum(x(:,iHop+1:iFftLength/4+iHop),1),iFftLength)*2/iFftLength;
 
    X       = X(:,1:iFftLength/2+1);
    f_I     = computeInstantaneousFreq(X,iHop, fs);
    
    X       = abs(X);
    [pks,k] = findpeaks(X(1,:));
    
    cLegend = {};
    for (i=1:length(fFreq))
        fDiff(i,:) = abs([fFreqRes*(k(i)-1)-fFreq(i) f_I(k(i))-fFreq(i)]);
        cLegend{i}          = ['$|f_{max}-f| = ' num2str(fDiff(i,1),'%2.2f') '$ Hz, $|f_I-f| = ' num2str(fDiff(i,2),'%2.2f') '$ Hz'];
    end
    cLegend = char(cLegend);
end

