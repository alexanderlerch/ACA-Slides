function displayDtw()
    
    if(exist('ToolSimpleDtw') ~=2)
        error('Please add the ACA scripts (https://github.com/alexanderlerch/ACA-Code) to your path!');
    end

%    fDimensions = [8.23, 7]; % weird dimension to work around epstopdf problems
    fDimensions = [8, 6.8]; % weird dimension to work around epstopdf problems
    hFigureHandle = generateFigure(fDimensions(1), fDimensions(2));
    
    [cPath, cName]  = fileparts(mfilename('fullpath'));
    cOutputFilePath = [cPath '/../graph/' strrep(cName, 'display', '')];
 
    % generate sample data
    [seq1, seq2, D, p, C] = generateDtwExampleData([cPath '/../audio/sq1.wav'], [cPath '/../audio/sq2.wav']);

    b = 4;
    k = fDimensions(2)/(b+2.75);
    s1Axis = subplot(224);
    plot(0:length(seq1)-1, seq1);
    xlabel('$n_\mathrm{A}$')
    ylabel('Seq.~A')
    axis ([0 length(seq1)-1 min(min(seq1),min(seq2)) max(max(seq1),max(seq2))]); grid on
    set(s1Axis, 'unit', 'centimeters', 'YTickLabel', []);
    set(s1Axis, 'position', [fDimensions(1)-(b+0.5)*k, fDimensions(2)-(b+2)*k, b*k, k]);

    s2Axis = subplot(221);
    plot(min(seq2)+max(seq2)-seq2, length(seq2)-1:-1:0);
    ylabel('$n_\mathrm{B}$')
    xlabel('Seq.~B')
    axis ([min(min(seq1),min(seq2)) max(max(seq1),max(seq2)) 0 length(seq2)-1]); grid on
    set(s2Axis, 'unit', 'centimeters', 'XTickLabel', []);
    set(s2Axis, 'position', [fDimensions(1)-(b+2)*k, fDimensions(2)-(b+0.5)*k, k, b*k]); 

    pathAxis = subplot(222);
    imagesc(0:size(D,2)-.5,0:size(D,1)-.5,D);
    colormap copper;
    box on;
    hold on; plot(p(:,2)-1,p(:,1)-1,'Color',[234/256 170/256 0]); hold off
    set(pathAxis, 'unit', 'centimeters');
    set(pathAxis, 'position', [fDimensions(1)-(b+0.5)*k, fDimensions(2)-(b+0.5)*k, b*k, b*k]); 

    yticks = get(gca,'YTick');
    yTickLabels = get(gca,'YTickLabel');
    set(s2Axis, 'ytick', fliplr(length(seq2)-yticks));
    set(s2Axis, 'yticklabel', flipud(yTickLabels));

    set(pathAxis,'YTickLabel',[]);
    set(pathAxis,'XTick',[]);
    printFigure(hFigureHandle, cOutputFilePath)
end


