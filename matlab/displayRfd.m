function displayRfd()

    hFigureHandle = generateFigure(10.8,5);
    
    [cPath, cName]  = fileparts(mfilename('fullpath'));
    cOutputFilePath = [cPath '/../graph/' strrep(cName, 'display', '')];
 
    % read sample data
    load handel.mat

    rdf     = histogram(y,128,'Normalization','probability');

    b = .16;
    y2  = 1/(2*b)*exp(-abs(rdf.BinLimits(1):rdf.BinWidth:rdf.BinLimits(2))./b);
    y2  = y2/sum(y2); % only approx.
    hold on;
    plot(rdf.BinLimits(1):rdf.BinWidth:rdf.BinLimits(2),y2)
    hold off;
    axis([-.8 .8 0 .05])
    legend('measured rfd', 'laplace dist');
    xlabel('x')
    ylabel('rel. num. of occurences')
    
    printFigure(hFigureHandle, cOutputFilePath)
end