function displayNoveltyFunction()

    hFigureHandle = generateFigure(12,4.8);
    
    if(exist('ComputeNoveltyFunction') ~=2)
        error('Please add the ACA scripts (https://github.com/alexanderlerch/ACA-Code) to your path!');
    end
   
    iStart  = 300000;
    iLength = 150000;
    
    [cPath, cName]  = fileparts(mfilename('fullpath'));
    cOutputFilePath = [cPath '/../graph/' strrep(cName, 'display', '')];
 
    % read sample data
    [x, fs] = audioread([cPath '/../audio/sax_example.wav'], [iStart iStart+iLength-1]);
    tx      = linspace(0,(iLength-1)/fs,iLength);
    x       = abs(x)/max(abs(x));
    
    [d, t]  = ComputeNoveltyFunction ('Flux', x, fs);

    [dn,th] = generateSampleData(d);

    plot(t,dn,t,th);
    xlabel('$t$ [s]')
    lh = legend('$d(t)$','$G(t)$');
    set(lh,'Interpreter','latex')
    axis([t(1) t(end) 0 1.05])
    
    printFigure(hFigureHandle, cOutputFilePath)
end

function [dn,tn] = generateSampleData(d)
    
    iFiltLen    = 25;
    fAbsThresh  = .2;
    fOffset     = .18;
    dn          = d/max(d);
    tn          = filtfilt(ones(iFiltLen,1)/iFiltLen,1,dn)+fOffset;
    
    tn(tn<fAbsThresh) = fAbsThresh;
    
end
