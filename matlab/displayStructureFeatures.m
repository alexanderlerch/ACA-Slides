function displayStructureFeatures()

    hFigureHandle = generateFigure(10.8,7);
 
    if(exist('ComputeFeature') ~=2)
        error('Please add the ACA scripts (https://github.com/alexanderlerch/ACA-Code) to your path!');
    end
    
    [cPath, cName]  = fileparts(mfilename('fullpath'));
    cOutputFilePath = [cPath '/../graph/' strrep(cName, 'display', '')];
 
     
    % generate sample data
    [t,pcd,mfcc,pc,acf,parts] = generateSampleData([cPath '/../audio/structure_example.mp3']);

    fi(1)=subplot(221);
    imagesc(t,1:size(pc,1),pc)
    axis xy
    ylabel('PC')
    
    fi(2)=subplot(222);
    imagesc(t,1:size(mfcc,1),mfcc)
    axis xy
    ylabel('MFCCs')
    
    fi(3)=subplot(223);
    imagesc(t,1:size(pcd,1),pcd)
    axis xy
    ylabel('$\Delta$PC')
    xlabel('t [s]')
    
    fi(4)=subplot(224);
    imagesc(t,1:size(acf,1),acf)
    axis xy
    ylabel('ACF')
    xlabel('t [s]')
    
    printFigure(hFigureHandle, [cOutputFilePath '_0'])
    
    ydim = [1 size(pc,1)-1; 1 size(mfcc,1)-1; 1 size(pc,1)-1; 1 size(acf,1)-1];
    for (i = 1: size(parts,1))
        if (parts(i,1) == 1)
            mycolor = [ 0 0 0 ];
        elseif (parts(i,1) == 2)
            mycolor = [1 0 0];
        else
            mycolor = [1 0 0];
        end
        for (f = 1:4)
            rectangle('parent',fi(f),'position',[ceil(parts(i,2)) ydim(f,1) floor(parts(i,3)-parts(i,2)) ydim(f,2)],'edgecolor',mycolor,'linewidth',2);
        end
    end
    printFigure(hFigureHandle, [cOutputFilePath '_1'])

end
