function displayTuningFreqDistribution()

    hFigureHandle = generateFigure(12,4);
    
    [cPath, cName]  = fileparts(mfilename('fullpath'));
    cOutputFilePath = [cPath '/../graph/' strrep(cName, 'display', '')];
 
    % read sample data
    [f,p]  = generateSampleData();

    bar(f,p,'k'), grid on
    axis([427 453 0 .25])

    xlabel('$f_\mathrm{A4}$ [Hz]');
    ylabel('RFD');

    printFigure(hFigureHandle, cOutputFilePath)
end

function [f,p] = generateSampleData()
    
    R       = load('TuningFreqRawData.txt');
    [p, f]  = hist(R,420:460);
    p = p/sum(p);
end