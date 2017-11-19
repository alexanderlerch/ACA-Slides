function displaySsmHomogeneity()

    hFigureHandle = generateFigure(15,8);
 
    if(exist('ComputeFeature') ~=2)
        error('Please add the ACA scripts (https://github.com/alexanderlerch/ACA-Code) to your path!');
    end
    
    [cPath, cName]  = fileparts(mfilename('fullpath'));
    cOutputFilePath = [cPath '/../graph/' strrep(cName, 'display', '')];
 
     
    % generate sample data
    [tx,x,t,pcd,mfcc,pc,acf,parts,labels] = generateStructureData([cPath '/../audio/structure-example.mp3']);

    acf = (pdist2(acf',acf'));
    acfn = 1-acf/max(max(acf));
    pc = (pdist2(pc',pc'));
    pcn = 1-pc/max(max(pc));

    %fi(1)=subplot(221);
    imagesc(t,t,pcn)
    title('PC')
    xlabel('t [s]')
    colormap(jet)
    rectangle('position',[75 75 6 6],'edgecolor',[0 0 1],'linewidth',2);

    printFigure(hFigureHandle, [cOutputFilePath '_0'])
    
    iFilterSize = 20;
    g = computeFilter(iFilterSize);
    output = filter2(g,pcn);
    plot(t,diag(output)),axis tight,
    hold on
    printFigure(hFigureHandle, [cOutputFilePath '_1'])
    myColorMap  = [
%                             0                         0                         0
                          0.75                      0.75                         0
                             234/256                    170/256                 0
                             0                         0                         1
                             1                         0                         0
                             0                       0.5                         0
                             0                      0.75                      0.75
                          0.75                         0                      0.75
                          0.25                      0.25                      0.25];
 
    for (i = 2: size(parts,1))
        mycolor = myColorMap(mod(parts(i,1),size(myColorMap,1)),:);
        plot([parts(i,2) parts(i,2)], [.8*max(diag(output)) max(diag(output))],'color',mycolor);
        text(parts(i,2),max(diag(output))-0.05,deblank(labels(i,:)),'color',mycolor);
    end
    printFigure(hFigureHandle, [cOutputFilePath '_2'])
end

function [kernel] = computeFilter(iFilterSize)
    %w = kron( [1 -1; -1 1], ones(iFilterSize/2,iFilterSize/2) );
    %kernel = (gausswin(iFilterSize) *gausswin(iFilterSize)');
    kernel = ones(iFilterSize)/iFilterSize^2;
end