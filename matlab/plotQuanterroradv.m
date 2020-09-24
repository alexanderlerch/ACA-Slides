function plotQuanterroradv (fDimensionsInCm, cAudioPath, cOutputPath)
    if(exist('ComputeFeature') ~=2)
        error('Please add the ACA scripts (https://github.com/alexanderlerch/ACA-Code) to your path!');
    end
    
    cDatasetPath = 'd:\dataset\music_speech\'; 
    localPath = 'h:/docs/repo/publications/2019-handbuchderaudiotechnik/';
    if nargin < 3
        cOutputPath = [localPath 'DigitaleAudioTechnik/graph/quanterroradv'];
        if nargin < 2
            cAudioPath = [localPath 'audio'];
        end
            if nargin < 1
                fDimensionsInCm = [ 4.05 , 2 ];
            end
    end

    % generate new figure
    hFigureHandle = generateFigure(fDimensionsInCm(1), fDimensionsInCm(2));

    cXLabel = 'Quantisierungsfehleramplitude $q$';
    cYLabel = '$p_\mathrm{Q}(q)$';
    
    [x,y] = GetData();
    
    plot(x,y)
    axis([x(1) x(end) -.2 3]);
    grid off; box off;
    ax = gca;
    ax.XAxisLocation = 'origin';
    ax.YAxisLocation = 'origin';
    xlabel(cXLabel)
    ylabel(cYLabel)
    set(gca,'XTick',[-.5 0 .5])
    set(gca,'YTick',[1])
    set(gca,'XTickLabel',{'$-\Delta/2$', '0','$\Delta/2$'})
    set(gca,'YTickLabel',{'$1/\Delta$'})
    

    printFigure(hFigureHandle, cOutputPath)
end

function     [q,pq] = GetData()

    delta = 1;
    q = [linspace(-delta/2-.1,delta/2+.1,1200)];
    pq = zeros(size(q));
    pq(q >= -delta/2 & q <= delta/2) = 1/delta;
    
end    