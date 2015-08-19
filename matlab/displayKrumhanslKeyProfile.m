function displayKrumhanslKeyProfile()

    hFigureHandle = generateFigure(10.8,5);
    
    [cPath, cName]  = fileparts(mfilename('fullpath'));
    cOutputFilePath = [cPath '/../graph/' strrep(cName, 'display', '')];

    % generate data
    [y] = generateSampleData();

    plot(y,'-o','MarkerFaceColor','k')
    set(gca,'XTick',1:12)
    set(gca,'XTickLabel',{'C', 'C#', 'D', 'D#', 'E','F', 'F#', 'G', 'G#', 'A', 'A#','B','C'})
    axis([1 12 0.05 .16])
    ylabel('Key Profile (CMaj)')
    xlabel('Pitch Class')
   
    printFigure(hFigureHandle, cOutputFilePath)
end


function [kp] = generateSampleData()

    kp =[
%        1       0       0       0       0       0       0       0       0       0       0       0 % diatonic
%        1       1       1       0       0       0       0       0       0       0       1       1 % smoothed orthogonal
%        1       0       1       0       1       1       0       1       0       1       0       1 % diatonic
%        j*circ/12 % circle of fifths
        6.35    2.23    3.48    2.33    4.38    4.09    2.52    5.19    2.39    3.66    2.29    2.88]; % krumhansl
%        0.748   0.06    0.488   0.082   0.67    0.46    0.096   0.715	0.104	0.366	0.057	0.4]; % temperley

    kp = kp/sum(kp);
end