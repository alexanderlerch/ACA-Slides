function displayKnn()

    [cPath, cName]  = fileparts(mfilename('fullpath'));
    cOutputFilePath = [cPath '/../graph/' strrep(cName, 'display', '')];
    hFigureHandle   = generateFigure(7,6);

    % class 1 data
    v1              =  [.1 .3
                        .05 .6
                        .12 .8
                        .35 .5
                        .45 .45
                        .6 .7]';
    v2              =  [.4 .9
                        .75 .85
                        .9 .75
                        .55 .5
                        .52 .45]';
    
	iFigIdx     = 0;
    iMarkerSize = 8;
    scatter(v1(1,:),v1(2,:), iMarkerSize*2,[0 0 0],'filled','o');
    axis([0 1 0 1]);
    set(gca,'XTickLabel',[],'YTickLabel',[]);
    hold on;
    scatter(v2(1,:),v2(2,:), iMarkerSize*2,[.8 0 0],'filled','o');
    printFigure(hFigureHandle, [cOutputFilePath '-' num2str(iFigIdx)]);iFigIdx = iFigIdx+1;
    scatter(.5,.5, iMarkerSize*3,[234/256 170/256 0],'filled','o');
    printFigure(hFigureHandle, [cOutputFilePath '-' num2str(iFigIdx)]);iFigIdx = iFigIdx+1;
    
    scatter(.5,.5, 700,[.5 .5 .5],'o');
    text(.6, .45,'$k=3$')
    printFigure(hFigureHandle, [cOutputFilePath '-' num2str(iFigIdx)]);iFigIdx = iFigIdx+1;
    scatter(.5,.5, 6000,[.5 .5 .5],'o');
    text(.7, .3,'$k=5$')
    printFigure(hFigureHandle, [cOutputFilePath '-' num2str(iFigIdx)]);iFigIdx = iFigIdx+1;
    scatter(.5,.5, 17000,[.5 .5 .5],'o');
    text(.8, .1,'$k=7$')
    printFigure(hFigureHandle, [cOutputFilePath '-' num2str(iFigIdx)]);iFigIdx = iFigIdx+1;
    hold off;
    
end