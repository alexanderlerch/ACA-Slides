function displaySequenceAlignment()

    fDimensions = [10.8, 6];
    hFigureHandle = generateFigure(fDimensions(1), fDimensions(2));
    
    if(exist('ToolSimpleDtw') ~=2)
        error('Please add the ACA scripts (https://github.com/alexanderlerch/ACA-Code) to your path!');
    end
   
    iStart  = 1;
    iLength = 280000;
    
    [cPath, cName]  = fileparts(mfilename('fullpath'));
    cOutputFilePath = [cPath '/../graph/' strrep(cName, 'display', '')];
 
    % generate sample data
    [seq1, seq2, D, p, C] = generateDtwExampleData([cPath '/../audio/sq1.wav'], [cPath '/../audio/sq2.wav']);

    seq1 = seq1-.4;
    seq2 = seq2+.4;
    for (i = 1:3:length(p))
        line([p(i,2) p(i,1)], [ seq1(p(i,2)) seq2(p(i,1))], 'LineWidth', .5, 'Color',[.5 .5 .5]);
    end
    hold on,plot(seq1)
    plot(seq2);hold off;
    axis([0 max(length(seq1),length(seq2)) -.8 .8]);
    set(gca,'visible','off');
    grid off; set(gca,'YTick',[],'XTick',[])

    printFigure(hFigureHandle, cOutputFilePath)
end
