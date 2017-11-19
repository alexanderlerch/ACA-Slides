function displaySdlm()

    hFigureHandle = generateFigure(15,8);
 
    if(exist('ComputeFeature') ~=2)
        error('Please add the ACA scripts (https://github.com/alexanderlerch/ACA-Code) to your path!');
    end
    
    [cPath, cName]  = fileparts(mfilename('fullpath'));
    cOutputFilePath = [cPath '/../graph/' strrep(cName, 'display', '')];
 
     
    % generate sample data
    [tx,x,t,pcd,mfcc,pc,acf,parts,labels] = generateStructureData([cPath '/../audio/structure-example.mp3']);

    pcd = pdist2(pcd',pcd');
    pc = pdist2(pc',pc');
    mfcc = pdist2(mfcc',mfcc');
    acf = pdist2(acf',acf');

    pcdn = pcd/max(max(pcd));
    pcn = pc/max(max(pc));
    mfccn = mfcc/max(max(mfcc));
    acfn = acf/max(max(acf));

    for (i = 1: length(t))
        for (k = 1: length(t)-i+1)
            pc(i,k) = 1-pcn(i+k-1,i);
            pcd(i,k) = 1-pcdn(i+k-1,i);
            mfcc(i,k) = 1-mfccn(i+k-1,i);
            acf(i,k) = 1-acfn(i+k-1,i);
        end
        pc(i,size(pc,2)-i+1:size(pc,2)) = 0;
        pcd(i,size(pcd,2)-i+1:size(pc,2)) = 0;
        mfcc(i,size(mfcc,2)-i+1:size(pc,2)) = 0;
        acf(i,size(acf,2)-i+1:size(pc,2)) = 0;
    end
%     iFilterSize = 6;
%     kernel = [-ones(iFilterSize,iFilterSize/2) ones(iFilterSize,iFilterSize/2)];
%     pc = filter2(kernel,1-pc);
%     mfcc = filter2(kernel,1-mfcc);
%     acf = filter2(kernel,1-acf);

    fi(1)=subplot(221);
    imagesc(t,t,pc)
    title('PC')
    ylabel('t [s]')
    colormap(jet)
    hold on;
    
    fi(2)=subplot(222);
    imagesc(t,t,mfcc)
    title('MFCCs')
    colormap(jet)
    hold on;
    
    fi(3)=subplot(223);
    imagesc(t,t,pcd)
    title('$\Delta$PC')
    xlabel('lag [s]')
    ylabel('t [s]')
    colormap(jet)
    hold on;
    
    fi(4)=subplot(224);
    imagesc(t,t,acf)
    title('ACF')
    xlabel('lag [s]')
    colormap(jet)
    hold on;

    printFigure(hFigureHandle, [cOutputFilePath '_0'])
  
    thresh = .5;
    pc(pc<thresh)= 0;
    mfcc(mfcc<thresh)= 0;
    acf(acf<thresh)= 0;

    combined = (pc.*acf.*mfcc);
    combined(combined<.3) = 0;
    subplot(111);
    imagesc(t,t,sqrt(combined));
    title('combined lag matrix')
    xlabel('lag [s]')
    colormap(jet)
    hold on;
    
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
            plot([1 1], [parts(i,2) parts(i,3)],'color',mycolor,'linewidth',3);
            for (k=1:size(parts,1))
                if (parts(i,1)~= parts(k,1)||i>=k)
                    continue;
                end
                plot([parts(k,2)-parts(i,2) parts(k,2)-parts(i,2)], [parts(i,2) parts(i,3)],'color',mycolor,'linewidth',3);
            end
        
    end
    printFigure(hFigureHandle, [cOutputFilePath '_2'])

end
