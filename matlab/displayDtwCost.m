function displayDtwCost()
    
    if(exist('ToolSimpleDtw') ~=2)
        error('Please add the ACA scripts (https://github.com/alexanderlerch/ACA-Code) to your path!');
    end

    fDimensions = [10.8, 5]; % weird dimension to work around epstopdf problems
    hFigureHandle = generateFigure(fDimensions(1), fDimensions(2));
    
    [cPath, cName]  = fileparts(mfilename('fullpath'));
    cOutputFilePath = [cPath '/../graph/' strrep(cName, 'display', '')];
 
    % generate sample data
    [seq1, seq2, D, p, C] = generateDtwExampleData([cPath '/../audio/sq1.wav'], [cPath '/../audio/sq2.wav']);

    subplot(131)
    imagesc(0:size(D,2)-.5,0:size(D,1)-.5,D);
    axis('tight')
    xlabel('$n_\mathrm{A}$')
    ylabel('$n_\mathrm{B}$')
    zlabel('Distance')

    m = size(D,2)/size(D,1);
    T = 35;
    D1 = D;
    for (i = 1:size(D,1))
        for (j = T:size(D,2))
            if (j >= round(m*i)+T)
                D1(i,j) = max(max(D));
            end
        end
    end
    for (i = T:size(D,1))
        for (j = 1:size(D,2))
            if (j <= round(m*i)-T)
                D1(i,j) = max(max(D));
            end
        end
    end
    subplot(132)
    imagesc(0:size(D,2)-.5,0:size(D,1)-.5,D1);
    xlabel('$n_\mathrm{A}$')
    ylabel('$n_\mathrm{B}$')
    title('Distance')
    subplot(133)
    imagesc(0:size(D,2)-.5,0:size(D,1)-.5,C);
    colormap jet;
    xlabel('$n_\mathrm{A}$')
    ylabel('$n_\mathrm{B}$')
    title('Cost')

    printFigure(hFigureHandle, cOutputFilePath)
end
