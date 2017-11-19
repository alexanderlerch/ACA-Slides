function displayStructure()

    hFigureHandle = generateFigure(12,4);
 
    if(exist('ComputeFeature') ~=2)
        error('Please add the ACA scripts (https://github.com/alexanderlerch/ACA-Code) to your path!');
    end
    
    [cPath, cName]  = fileparts(mfilename('fullpath'));
    cOutputFilePath = [cPath '/../graph/' strrep(cName, 'display', '')];
 
     
    % generate sample data
    [tx,x,t,pcd,mfcc,pc,acf,parts,labels] = generateStructureData([cPath '/../audio/structure-example.mp3']);

    f=plot(tx,x)
    xlabel('t [s]')
    axis([t(1) t(end) -1 1])
    hold on;
    
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
        plot([parts(i,2) parts(i,2)], [-1 0],'color',mycolor);
        text(parts(i,2),-0.95,deblank(labels(i,:)),'color',mycolor);
    end
    printFigure(hFigureHandle, cOutputFilePath)

end
