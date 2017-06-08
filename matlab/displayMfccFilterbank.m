function displayMfccFilterbank()

    hFigureHandle = generateFigure(12,4);
    
    [cPath, cName]  = fileparts(mfilename('fullpath'));
    cOutputFilePath = [cPath '/../graph/' strrep(cName, 'display', '')];
 
    % read sample data
    [f, H]  = generateSampleData();

    semilogx(f,H)
    set(gca,'XTick', [])
    xlabel('$f$ (log scale)')
    ylabel('$|H(k)|$')
    axis([133 7000 0.001 0.016])

    printFigure(hFigureHandle, cOutputFilePath)
end

function [f,H] = generateSampleData()
    fs          = 16000;
    iLength     = 16384;
    H           = ToolMfccFb(iLength, fs)';
    
    f           = linspace(0, fs/2, iLength);
end