function displayAdditiveSynthesis()

    hFigureHandle = generateFigure(10.8,5);
    
    [cPath, cName]  = fileparts(mfilename('fullpath'));
    cOutputFilePath = [cPath '/../graph/' strrep(cName, 'display', '')];

    aiOrder = [1 3 10 25 50];

    % generate sample data
    [t, x_sa, x_re] = generateSampleData (aiOrder);

    colorGtGold = [234, 170, 0]/256;
    colorGrey   = .7*ones(1,3);
    
    % plot saw
    for (i = 1:size(x_sa,1)-1)
        plot (t,x_sa(1,:), 'Color', colorGrey)
        hold on;
        plot (t,x_sa(i+1,:), 'Color', colorGtGold)
        hold off;  
        axis([-.5 .5 -1.25 1.25]);
        ylabel('$x_\mathrm{Saw}$')
        xlabel('$t / T_0$')
        lh = legend('Perfect',[num2str(aiOrder(i)) ' Harmonics'], 'Location', 'SouthWest');
        printFigure(hFigureHandle, [cOutputFilePath 'Saw-' num2str(i)])
    end
    
    % plot saw
    for (i = 1:size(x_re,1)-1)
        plot (t,x_re(1,:), 'Color', colorGrey)
        hold on;
        plot (t,x_re(i+1,:), 'Color', colorGtGold)
        hold off;  
        axis([-.5 .5 -1.25 1.25]);
        ylabel('$x_\mathrm{Rect}$')
        xlabel('$t / T_0$')
        lh = legend('Perfect',[num2str(aiOrder(i)) ' Harmonics'], 'Location', 'SouthWest');
        printFigure(hFigureHandle, [cOutputFilePath 'Rect-' num2str(i)])
    end

end

function [t, x_sa, x_re, audio_sa, audio_re] = generateSampleData(iOrder)
    iLength = 16384;
    t = linspace(-.5,.5, iLength);
    x_sa(1,:) = [linspace(0,1,iLength/2), linspace(-1,0-1/iLength,iLength/2)];
    x_re(1,:) = [ones(1,iLength/2), -ones(1,iLength/2)];

    iIdx   = 2;
    curr(1,:)    = zeros(1,length(t));
    for i = 1:iOrder(end)
        n = [];
        curr = curr + 2/pi/i * -sin(2*pi*i*t);
        n = find (iOrder == i);
        if (~isempty(n))
            x_sa(iIdx,:) = curr;
            iIdx        = iIdx + 1;
        end
    end
    iIdx   = 2;
    curr(1,:)    = zeros(1,length(t));
    for i = 1:iOrder(end)
        n = [];
        curr = curr + 4/pi/(2*i-1) * -sin(2*pi*(2*i-1)*t);
        n = find (iOrder == i);
        if (~isempty(n))
            x_re(iIdx,:) = curr;
            iIdx        = iIdx + 1;
        end
    end
end