function animateCurseOfDimensionality()

    bVideoOut     = false;
    
    [cPath, cName]  = fileparts(mfilename('fullpath'));
    if bVideoOut
        cOutputFilePath = [cPath '/../video/' strrep(cName, 'display', '')];
    else
        mkdir([cPath '/../graph/' cName '/']);
        cOutputFilePath = [cPath '/../graph/' cName '/' strrep(cName, 'animate', '')];
    end
 
    if bVideoOut
        writerObj = VideoWriter([cOutputFilePath '.mp4'],'MPEG-4');
        writerObj.FrameRate = 10;
        writerObj.Quality   = 100;
        open(writerObj);
    end

  
    hFigureHandle = generateFigure(8,4);
    plot(0:.1:100,zeros(1,1001))
    hold on;
    plot(0:.1:1, zeros(1,11),'Color', [234/256 170/256 0],'LineWidth',3)
    hold off;
    set(gca,'XTickLabel',[],'YTickLabel',[])
    axis([ 0 100 -50 50])
    printFigure(hFigureHandle, [cOutputFilePath '-00']); 
    
    hFigureHandle = generateFigure(8,4);
    plot(0:.1:100,zeros(1,1001))
    hold on;
    area(0:.1:10, 10*ones(1,101),'FaceColor', [234/256 170/256 0])
    hold off;
    set(gca,'XTickLabel',[],'YTickLabel',[])
    axis([ 0 100 0 100])
    printFigure(hFigureHandle, [cOutputFilePath '-01']); 
    
    hFigureHandle = generateFigure(8,4);
    plot3(0:.1:100,zeros(1,1001),zeros(1,1001))
    hold on;
    ver = [1 1 0;
    0 1 0;
    0 1 1;
    1 1 1;
    0 0 1;
    1 0 1;
    1 0 0;
    0 0 0];
%  Define the faces of the unit cubic
fac = [1 2 3 4;
    4 3 5 6;
    6 7 8 5;
    1 2 8 7;
    6 7 1 4;
    2 3 5 8];
cube = [ver(:,1),ver(:,2),ver(:,3)]*10000^(1/3);
patch('Faces',fac,'Vertices',cube,'FaceColor',[234/256 170/256 0]);
hold off;
    set(gca,'XTickLabel',[],'YTickLabel',[])
    axis([ 0 100 0 100 0 100])
    view(19,25)
    printFigure(hFigureHandle, [cOutputFilePath '-02']); 
end
