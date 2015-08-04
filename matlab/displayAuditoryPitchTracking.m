function displayAuditoryPitchTracking()

    hFigureHandle = generateFigure(10.8,7);
    
    [cPath, cName]  = fileparts(mfilename('fullpath'));
    cOutputFilePath = [cPath '/../graph/' strrep(cName, 'display', '')];
 
    % read sample data
    [t,x, f,X]  = generateSampleData();

    cXLabel     = char('$t$ [s]','$f$ [Hz]');
    cYLabelTime = char('$x(i)$','$x_\mathrm{HWR}(i)$','$x_\mathrm{S,HWR}(i)$');
    cYLabelFreq = char('$|X(k,n)|$','$|X_\mathrm{HWR}(k,n)|$','$|X_\mathrm{S,HWR}(k,n)|$');
    yTicksTime  = [-4 0 4
                    0 2 4
                    0 .5 1];


    for (i = 1:3)
        subplot(3,2,2*i-1)
        plot(t,x(i,:));
        ylabel(deblank(cYLabelTime(i,:)));
        set(gca,'YTick',yTicksTime(i,:))
        axis('tight')
        if (i==1) title('time domain'); end;
        if (i==3) xlabel(deblank(cXLabel(1,:))); end;

        subplot(3,2,2*i)
        plot(f,X(i,:));
        ylabel(deblank(cYLabelFreq(i,:)));
        axis([f(1) f(end) 0.01 1.2])
        if (i==1) title('frequency domain'); end;
        if (i==3) xlabel(deblank(cXLabel(2,:))); end;
    end

    printFigure(hFigureHandle, cOutputFilePath)
end

function [t,x, f,X] = generateSampleData()
    
    iBlockSize  = 2048;
    fs          = 192000;
    dLengthInS  = iBlockSize/192000;
    iFilterLength = 128;
    maxFreq     = 7000;
    numReps     = 16;

    f_0     = 187.5;
    f       = f_0*[13 14 15 16 17];

    [x,t]   = generateSineWave(f(1), dLengthInS, fs);
    for (i = 2:length(f))
        x   = x + generateSineWave(f(i), dLengthInS, fs);
    end

    % periodic continuation
    fftSize = (numReps*iBlockSize);
    f       = (0:fftSize)*fs/fftSize;
    f       = f(find(f <= maxFreq));

    timesig = repmat(x(1,:), 1,numReps);
    tmp     = abs(fft(timesig))*2/fftSize;
    X       = tmp(1:length(f));

    % HWR
    x(2,:)              = x(1,:);
    x(2,find(x(2,:)<0)) = 0;        

    timesig = repmat(x(2,:), 1,numReps);
    tmp     = abs(fft(timesig))*2/fftSize;
    X(2,:)  = tmp(1:length(f));

    % low pass filter
    x(3,:)              = x(2,:);
    tmp                 = filtfilt(ones(iFilterLength,1)/iFilterLength,1,[x(3,:) x(3,:) x(3,:)]);
    x(3,:)              = tmp(length(x)+1:2*length(x));

    timesig = repmat(x(3,:),1, numReps);
    tmp     = abs(fft(timesig))*2/fftSize;
    X(3,:)  = tmp(1:length(f));

%     % flip them
%     x = x';
%     X = X';
%     t = t';
%     f = f';
end

function [x,t] = generateSineWave(fFreq, fLengthInS, fSampleRateInHz)
    t = linspace(0,fLengthInS-1/fSampleRateInHz,fSampleRateInHz*fLengthInS);
    
    x = sin(2*pi*fFreq*t);
end