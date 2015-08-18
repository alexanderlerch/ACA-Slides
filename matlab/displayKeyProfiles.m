function displayKeyProfiles()

    hFigureHandle = generateFigure(10.8,8);
    
    [cPath, cName]  = fileparts(mfilename('fullpath'));
    cOutputFilePath = [cPath '/../graph/' strrep(cName, 'display', '')];

        myColorMap  = [
                             0                         0                         0
                             234/256                    170/256                 0
                             0                         0                         1
                             1                         0                         0
                             0                       0.5                         0
                             0                      0.75                      0.75
                          0.75                         0                      0.75
                          0.75                      0.75                         0
                          0.25                      0.25                      0.25];

    % generate data
    [y,d,circ] = generateSampleData();

    subplot(221),
    h = bar(0:11,abs(y)',1,'group');
    xlabel('$\mathrm{PC}$')
    ylabel('$\nu$')
    axis([-.5 11.5 0 1])
    for (i = 1: length(h))
        set(h(i),'facecolor', myColorMap (mod(i-1,size(myColorMap,1))+1,:)); 
    end
    
    
    subplot(223)
    plot(0:12, d)
    set(gca,'XTick',0:12)
    set(gca,'XTickLabel',{'C', 'C#', 'D', 'D#', 'E','F', 'F#', 'G', 'G#', 'A', 'A#','B','C'})
    axis([0 12 0 1.5])
    xlabel('Key')
    ylabel('$d_\mathrm{E} (C\ Maj.)$')
    
    subplot(122)
    scale           = 1.9/sqrt(2);
    [theta, idx]    = sort(circ+12);
    d               = d*scale;
    for (i = 1:size(d,1))
        h = polar ([theta theta(1)]/12*2*pi+pi/2,[d(i,idx) d(i,idx(1))]);
        hold on;
    end
    hold off;    
    ph=findall(gca,'type','text');
    ps=get(ph,'string');
    ps(1:end)={''};
    ps =  {'A','Eb','E','Bb', 'B', 'F', 'F\#', 'C','Db', 'G', 'Ab', 'D', '', '','Distance to C Major','',''};
    set(ph,{'string'},ps');
    h_legend=legend('o', 's', 'd', '5', 'p', 't','Location','southeast');
   
    printFigure(hFigureHandle, cOutputFilePath)
end


function [kp,dist,circ] = generateSampleData()

    circ = [0 -5 2 -3 4 -1 6 1 -4 3 -2 5];
    kp =[
        1       0       0       0       0       0       0       0       0       0       0       0 % diatonic
        1       1       1       0       0       0       0       0       0       0       1       1 % smoothed orthogonal
        1       0       1       0       1       1       0       1       0       1       0       1 % diatonic
        j*circ/12 % circle of fifths
        6.35    2.23    3.48    2.33    4.38    4.09    2.52    5.19    2.39    3.66    2.29    2.88 % krumhansl
        0.748   0.06    0.488   0.082   0.67    0.46    0.096   0.715	0.104	0.366	0.057	0.4]; % temperley
    kp(4,:)  = exp(kp(4,:));

    % set the circle radius to 2
    R       = 1;
    kp(4,:)  = kp(4,:)*R;

    norm    = sqrt(sum(kp.^2,2));
    for (i = 2:size(kp,1))
        kp(i,:)  = kp(i,:) / norm(i);
    end

    dist = zeros(size(kp,1), size(kp,1)+1);
    for (k = 1: size(kp,1))
        for (i = 0:12)
            dist(k,i+1)    = sqrt((kp(k,:)-circshift(kp(k,:),[0 i]))*(kp(k,:)-circshift(kp(k,:),[0 i]))');
        end
    end
end