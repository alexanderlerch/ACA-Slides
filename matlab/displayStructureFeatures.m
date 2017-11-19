function displayStructureFeatures()

    hFigureHandle = generateFigure(15,8);
 
    if(exist('ComputeFeature') ~=2)
        error('Please add the ACA scripts (https://github.com/alexanderlerch/ACA-Code) to your path!');
    end
    
    [cPath, cName]  = fileparts(mfilename('fullpath'));
    cOutputFilePath = [cPath '/../graph/' strrep(cName, 'display', '')];
 
     
    % generate sample data
    [tx,x,t,pcd,mfcc,pc,acf,parts, labels] = generateStructureData([cPath '/../audio/structure-example.mp3']);

    fi(1)=subplot(221);
    imagesc(t,1:size(pc,1),pc)
    hold on;
    axis xy
    ylabel('PC')
    
    fi(2)=subplot(222);
    imagesc(t,1:size(mfcc,1),mfcc)
    hold on;
    axis xy
    ylabel('MFCCs')
    
    fi(3)=subplot(223);
    imagesc(t,1:size(pcd,1),pcd)
    hold on;
    axis xy
    ylabel('$\Delta$PC')
    xlabel('t [s]')
    
    fi(4)=subplot(224);
    imagesc(t,1:size(acf,1),acf)
    hold on;
    axis xy
    ylabel('ACF')
    xlabel('t [s]')
    
    printFigure(hFigureHandle, [cOutputFilePath '_0'])
    
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
 

    ydim = [1 size(pc,1)-1; 1 size(mfcc,1)-1; 1 size(pc,1)-1; 1 size(acf,1)-1];
    for (i = 2: size(parts,1))
        mycolor = myColorMap(mod(parts(i,1),size(myColorMap,1)),:);
        for (f = 1:4)
            rectangle('parent',fi(f),'position',[ceil(parts(i,2)) ydim(f,1) floor(parts(i,3)-parts(i,2)) ydim(f,2)],'edgecolor',mycolor,'linewidth',2);
            plot(fi(f),[parts(i,2) parts(i,2)], [-1 0],'color',mycolor);
            text(fi(f),1.01*ceil(parts(i,2)),2,deblank(labels(i,:)),'color',mycolor,'fontsize',8);
            
        end
    end
    printFigure(hFigureHandle, [cOutputFilePath '_1'])

end
