function displaySsm()

    hFigureHandle = generateFigure(10.8,7);
 
    if(exist('ComputeFeature') ~=2)
        error('Please add the ACA scripts (https://github.com/alexanderlerch/ACA-Code) to your path!');
    end
    
    [cPath, cName]  = fileparts(mfilename('fullpath'));
    cOutputFilePath = [cPath '/../graph/' strrep(cName, 'display', '')];
 
     
    % generate sample data
    [t,pcd,mfcc,pc,acf,parts] = generateStructureData([cPath '/../audio/structure_example.mp3']);

    pcd = (pdist2(pcd',pcd'));
    pc = (pdist2(pc',pc'));
    mfcc = (pdist2(mfcc',mfcc'));
    acf = (pdist2(acf',acf'));

    pcdn = 1-pcd/max(max(pcd));
    pcn = 1-pc/max(max(pc));
    mfccn = 1-mfcc/max(max(mfcc));
    acfn = 1-acf/max(max(acf));

    fi(1)=subplot(221);
    imagesc(t,t,pcn)
    title('PC')
    ylabel('t [s]')
    colormap(jet)
    hold on;
    
    fi(2)=subplot(222);
    imagesc(t,t,mfccn)
    title('MFCCs')
    colormap(jet)
    hold on;
    
    fi(3)=subplot(223);
    imagesc(t,t,pcdn)
    title('$\Delta$PC')
    xlabel('t [s]')
    ylabel('t [s]')
    colormap(jet)
    hold on;
    
    fi(4)=subplot(224);
    imagesc(t,t,acfn)
    title('ACF')
    xlabel('t [s]')
    colormap(jet)
    hold on;
    
    printFigure(hFigureHandle, [cOutputFilePath '_0'])
 
    fi(1)=subplot(221);
    imagesc(t,t,pcn.^2)
    title('PC (square)')
    ylabel('t [s]')
    colormap(jet)
    hold on;
    
    fi(2)=subplot(222);
    imagesc(t,t,mfccn.^2)
    title('MFCCs (square)')
    colormap(jet)
    hold on;
    
    fi(3)=subplot(223);
    imagesc(t,t,pcdn.^2)
    title('$\Delta$PC (square)')
    xlabel('t [s]')
    ylabel('t [s]')
    hold on;
    
    fi(4)=subplot(224);
    imagesc(t,t,acfn.^2)
    title('ACF (square)')
    xlabel('t [s]')
    colormap(jet)
    hold on;
    
    printFigure(hFigureHandle, [cOutputFilePath '_1'])

    fi(1)=subplot(221);
    imagesc(t,t,sqrt(pcn))
    title('PC (sqrt)')
    ylabel('t [s]')
    colormap(jet)
    hold on;
    
    fi(2)=subplot(222);
    imagesc(t,t,sqrt(mfccn))
    title('MFCCs (sqrt)')
    colormap(jet)
    hold on;
    
    fi(3)=subplot(223);
    imagesc(t,t,sqrt(pcdn))
    title('$\Delta$PC (sqrt)')
    xlabel('t [s]')
    ylabel('t [s]')
    colormap(jet)
    hold on;
    
    fi(4)=subplot(224);
    imagesc(t,t,sqrt(acfn))
    title('ACF (sqrt)')
    xlabel('t [s]')
    colormap(jet)
    hold on;
    
    printFigure(hFigureHandle, [cOutputFilePath '_2'])

    fi(1)=subplot(221);
    imagesc(t,t,atan((pcn-.5)*10)/pi+.5)
    title('PC (atan)')
    ylabel('t [s]')
    colormap(jet)
    hold on;
    
    fi(2)=subplot(222);
    imagesc(t,t,atan((mfccn-.5)*10)/pi+.5)
    title('MFCCs (atan)')
    colormap(jet)
    hold on;
    
    fi(3)=subplot(223);
    imagesc(t,t,atan((pcdn-.5)*10)/pi+.5)
    title('$\Delta$PC (atan)')
    xlabel('t [s]')
    ylabel('t [s]')
    colormap(jet)
    hold on;
    
    fi(4)=subplot(224);
    imagesc(t,t,atan((acfn-.5)*10)/pi+.5)
    title('ACF (atan)')
    xlabel('t [s]')
    colormap(jet)
    hold on;
    
    printFigure(hFigureHandle, [cOutputFilePath '_3'])

    fi(1)=subplot(221);
    imagesc(t,t,pcn)
    title('PC')
    ylabel('t [s]')
    colormap(jet)
    hold on;
    
    fi(2)=subplot(222);
    imagesc(t,t,mfccn)
    title('MFCCs')
    colormap(jet)
    hold on;
    
    fi(3)=subplot(223);
    imagesc(t,t,pcdn)
    title('$\Delta$PC')
    xlabel('t [s]')
    ylabel('t [s]')
    colormap(jet)
    hold on;
    
    fi(4)=subplot(224);
    imagesc(t,t,acfn)
    title('ACF')
    xlabel('t [s]')
    colormap(jet)
    hold on;
    
    for (i = 1: size(parts,1))
        if (parts(i,1) == 1)
            mycolor = [ 0 0 0 ];
        elseif (parts(i,1) == 2)
            mycolor = [1 0 0];
        else
            mycolor = [1 0 0];
        end
        for (f = 1:4)
            plot(fi(f),[parts(i,2) parts(i,3)], [parts(i,2) parts(i,3)],'color',mycolor);
            for (k=1:size(parts,1))
                if (parts(i,1)~= parts(k,1)||i==k)
                    continue;
                end
                plot(fi(f),[parts(i,2) parts(i,3)], [parts(k,2) parts(k,3)],'color',mycolor);
            end
        end
        for (f = 1:4)
            plot(fi(f),[parts(i,2) parts(i,3)], [parts(i,2) parts(i,3)],'color',mycolor);
        end
        
    end
    printFigure(hFigureHandle, [cOutputFilePath '_4'])

end
