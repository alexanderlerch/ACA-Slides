function displayMean()

    if(exist('ComputeFeature') ~=2)
        error('Please add the ACA scripts (https://github.com/alexanderlerch/ACA-Code) to your path!');
    end

    hFigureHandle = generateFigure(8,6.8);
    
    iStart  = 1;
    iLength = 2^17;
    
    [cPath, cName]  = fileparts(mfilename('fullpath'));
    cOutputFilePath = [cPath '/../graph/' strrep(cName, 'display', '')];

    cFeatureNames = char('SpectralCentroid');

    % read sample data
    [cPath, cName]  = fileparts(mfilename('fullpath'));
    [x,fs]  = audioread([cPath '/../audio/sax_example.wav'],[iStart iStart+iLength-1]);
    t       = linspace(0,(length(x)-1)/fs,length(x));
    x       = x/max(abs(x));
 
    for (i=1:size(cFeatureNames,1))
        [v, tv]         = ComputeFeature (deblank(cFeatureNames(i,:)), x, fs);

        
        subplot(211), 
        plot(tv,v),
        axis([tv(1) tv(end) 0 1200])
        hold on;
        line([tv(1) tv(end)],mean(v)*ones(1,2),'LineWidth', 2.5,'Color',[234/256 170/256 0])
        hold off;
        text(2.25, 600, sprintf('$\\mu_x =%2.2f$',mean(v)));
        xlabel('$t$ [s]')
        ylabel('$x(t)$')
        
        subplot(212)
        hist(v,25)
        h = findobj(gca,'Type','patch');
        h.FaceColor = [0.5 0.5 0.5];
        %h.EdgeColor = 'w';
        hold on;
        line(mean(v)*ones(1,2), [0 20],'LineWidth', 2.5,'Color',[234/256 170/256 0])
        hold off;
        text(500, 18, sprintf('$\\mu_x =%2.2f$',mean(v)));
        xlabel('$x$')
        ylabel('$d_x(x)$')
        
        printFigure(hFigureHandle, cOutputFilePath)
    end
end