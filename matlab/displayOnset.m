function displayOnset()

    hFigureHandle = generateFigure(10.8,5);
    
    iStart  = 330000;
    iLength = 8192;
    
    [cPath, cName]  = fileparts(mfilename('fullpath'));
    cOutputFilePath = [cPath '/../graph/' strrep(cName, 'display', '')];
 
    % read sample data
    [t,x,v,iOnsetIdx] = generateSampleData([cPath '/../audio/sax_example.wav'], [iStart iStart+iLength-1]);

    plot(t,x, 'LineWidth',1);
    hold on
    plot(t,v, 'LineWidth',2);
    stem(t(iOnsetIdx),v(iOnsetIdx),'fill','r')
    hold off
    xlabel('$t$ [s]')
    ylabel('$|x(t)|$')
    axis([t(1) t(end) 0 1.1])
    text(0.04,-0.05+v(iOnsetIdx),'onset time');
    text(0.03,1.02,'$\leftarrow$\quad attack time\quad $\rightarrow$');
    
    printFigure(hFigureHandle, cOutputFilePath)
end

function[t,x,v,iOnsetIdx] = generateSampleData(cFilePath, aiSampleIdx)
    
    iLength = aiSampleIdx(2)-aiSampleIdx(1)+1;
    alpha   = 1-1e-3;

    [x, fs] = audioread(cFilePath, aiSampleIdx);
    t       = linspace(0,(iLength-1)/fs,iLength);
    x       = abs(x)/max(abs(x));

    %super simple envelope + onset detection
    v       = [x(1) zeros(1,iLength-1)];
    for (i = 2:iLength)
        v(i)    = max(x(i), alpha*v(i-1));
    end
    L = 64;
    v = filtfilt(1/L*ones(1,L),1,v);
    
    tmp = diff(v);

    [dummy,iOnsetIdx] = max(tmp);
end
