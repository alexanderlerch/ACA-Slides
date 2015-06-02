function displayRandomProcess()

    hFigureHandle = generateFigure(10.8,8);
    
    iLength = 512;
    
    [cPath, cName]  = fileparts(mfilename('fullpath'));
    cOutputFilePath = [cPath '/../graph/' strrep(cName, 'display', '')];
 
    % generate sample data
    xr      = .125*randn(5,iLength);
    
    scale   = ceil(10*max(max(abs(xr))))/10;
    
    for (i = 2:size(xr,1)-1)
        subplot(size(xr,1),1,i)
        plot(xr(i,:),'Linewidth',1)
        ylabel(['sample ' num2str(i)])
        axis([1 iLength -scale scale])
        set(gca,'XTick',[])
        set(gca,'YTick',[])
%         set(gca,'xcolor',[1 1 1])
%         set(gca,'ycolor',[1 1 1])
    end
    xlabel('t [s]')
    
    annotation(hFigureHandle,'line',[0.30 0.30],[0.80 0.25]);
    annotation(hFigureHandle,'line',[0.60 0.60],[0.80 0.25]);
    annotation(hFigureHandle,'textbox',[0.29 0.19 0.10 0.10],...
    'String',{'f_X(x,t_1)'},...
    'LineStyle','none');
    annotation(hFigureHandle,'textbox',[0.59 0.19 0.10 0.10],...
    'String','f_X(x,t_2)',...
    'LineStyle','none');
    annotation(hFigureHandle,'textbox',[0.20 0.20 0.1 0.1],...
    'String',{'.','.','.','.'},...
    'LineStyle','none');
    annotation(hFigureHandle,'textbox',[0.20 0.90 0.1 0.1],...
    'String',{'.','.','.'},...
    'LineStyle','none');
    annotation(hFigureHandle,'textbox',[0.50 0.20 0.1 0.1],...
    'String',{'.','.','.','.'},...
    'LineStyle','none');
    annotation(hFigureHandle,'textbox',[0.50 0.90 0.1 0.1],...
    'String',{'.','.','.'},...
    'LineStyle','none');
    annotation(hFigureHandle,'textbox',[0.80 0.20 0.1 0.1],...
    'String',{'.','.','.','.'},...
    'LineStyle','none');
    annotation(hFigureHandle,'textbox',[0.80 0.90 0.1 0.1],...
    'String',{'.','.','.'},...
    'LineStyle','none');


    printFigure(hFigureHandle, cOutputFilePath)
end