function displayKMeans()

    [cPath, cName]  = fileparts(mfilename('fullpath'));
    cOutputFilePath = [cPath '/../graph/' strrep(cName, 'display', '')];
    hFigureHandle   = generateFigure(7,6);

    % class 1 data
    v              =  [.1 .5
                        .05 .6
                        .12 .8
                        .35 .3
                        .45 .25
                        .6 .7
                        .61 .9
                        .75 .85
                        .9 .75
                        .55 .35
                        .52 .2]';
    numClusters = 3;
	iFigIdx     = 0;
    iMarkerSize = 8;
    scatter(v(1,:),v(2,:), iMarkerSize*2,[0 0 0],'filled','o');
    axis([0 1 0 1]);
    set(gca,'XTickLabel',[],'YTickLabel',[]);
    set(gca,'visible','off');
    plotcolor = [.8 0 0];
    printFigure(hFigureHandle, [cOutputFilePath '-' num2str(iFigIdx)]);iFigIdx = iFigIdx+1;
    [clusterIdx,state] = computeKMeans(v, numClusters, 1);
    printFigure(hFigureHandle, [cOutputFilePath '-' num2str(iFigIdx)]);iFigIdx = iFigIdx+1;
    for (i = 1:5)
        scatter(v(1,:),v(2,:), iMarkerSize*2,[0 0 0],'filled','o');
        axis([0 1 0 1]);set(gca,'visible','off');
        set(gca,'XTickLabel',[],'YTickLabel',[]);
        hold on;
        for k=1:numClusters
            scatter(state.m(1,k),state.m(2,k), iMarkerSize*8,circshift(plotcolor,[0 k-1]),'filled','s');
            scatter(v(1,clusterIdx==k),v(2,clusterIdx==k), iMarkerSize*2,circshift(plotcolor,[0 k-1]),'filled','o');
        end
        hold off;
        [clusterIdx,state] = computeKMeans(v, numClusters, 1,state);
        printFigure(hFigureHandle, [cOutputFilePath '-' num2str(iFigIdx)]);iFigIdx = iFigIdx+1;
    end    
end