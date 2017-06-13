function displayFreqDomainPitchError()

    hFigureHandle = generateFigure(12,5);
    
    [cPath, cName]  = fileparts(mfilename('fullpath'));
    cOutputFilePath = [cPath '/../graph/' strrep(cName, 'display', '')];
 
    % read sample data
    [f,e_p,cLegend]  = generateSampleData();
    
    plot(f,e_p,'LineWidth',.5);
    axis([f(1) 2000 -1000 1000])
    
    xlabel('$f$ [Hz]');
    ylabel('$1200\cdot\log_2\left(\frac{f_\mathrm{Q}}{f}\right)$ [cent]');
    lh = legend(cLegend);
    set(lh,'Location','NorthEast','Interpreter','latex')

    printFigure(hFigureHandle, cOutputFilePath)
end

function [f,e_p,cLegend] = generateSampleData()

    fs      = fliplr([44100,48000,96000]);
    iLength = 2048;
    f       = linspace(20, 3000, 2^16);
    cLegend = {};
    
    for i=1:length(fs)
        fq(i,:)    = round( f/fs(i)*iLength )*fs(i)/iLength;
        e_p(i,:)   = (1200*log2(f./fq(i,:)));
        cLegend{i} = ['$f_\mathrm{S} = ' num2str(fs(i)/1000) '$ kHz'];
    end
    cLegend = char(cLegend);
end

