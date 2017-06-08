function displayMfccMelDct()

    hFigureHandle = generateFigure(12,6);
    
    [cPath, cName]  = fileparts(mfilename('fullpath'));
    cOutputFilePath = [cPath '/../graph/' strrep(cName, 'display', '')];
 
    % read sample data
    [x, Y]  = generateSampleData();

    numCols = 4;
    for (i = 1:size(Y,2))
        subplot(size(Y,2)/numCols,numCols,i),
        plot(x,Y(:,i)),
        axis([x(1) x(end) -1 1])
        grid on

        if (mod(i,numCols) == 1)
            ylabel('$H(f)$');
        else
            set(gca,'YTickLabel','');
        end
        if (i/numCols > (size(Y,2)/numCols -1))
            xlabel('$f$ [kHz]');
        else
            set(gca,'XTickLabel','');
        end
    end
    
    printFigure(hFigureHandle, cOutputFilePath)
end

function [f,Y] = generateSampleData()
    K = 3000;
    m = 1:K;

    f = 700 * (10.^(m/2595)-1);

    k = 1:K;

    for (i = 1:16)
        Y(:,i) = cos(i*pi/K*(k-.5));
    end

    f   = f/1000;
end