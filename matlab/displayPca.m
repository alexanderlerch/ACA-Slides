function displayPca()

    addpath(fullfile(docroot,'techdoc','creating_plots','examples'))

    hFigureHandle = generateFigure(10.8,5);
    
    [cPath, cName]  = fileparts(mfilename('fullpath'));
    cOutputFilePath = [cPath '/../graph/' strrep(cName, 'display', '')];
 
    % generate sample data
    [x, pc] = generateSampleData();

    fig(1) = subplot(121);
    scatter(x(:,1),x(:,2),2,'k');
    axis square;
    axis([-4 4 -4 4]);
    box('on');
    grid('on');
    xlabel('$x_1$')
    ylabel('$x_2$')
 
    [figx figy] = dsxy2figxy([-2.5 2.5],[0 0]);
    annotation('textarrow',figx,figy, 'String', '$x_1$',...
             'Interpreter','latex','FontSize',6,'Headlength',5,'HeadWidth',4)
    [figx figy] = dsxy2figxy([0 0],[-2.5 2.5]);
    annotation('textarrow',figx,figy, 'String', '$x_2$',...
             'Interpreter','latex','FontSize',6,'Headlength',5,'HeadWidth',4)
    
    fig(2) = subplot(122);
    scatter(x(:,1),x(:,2),2,'k');
    axis square;
    axis([-4 4 -4 4]);
    box('on');
    grid('on');
    xlabel('$x_1$')
    ylabel('$x_2$')
  
    [figx figy] = dsxy2figxy(2.5*[-1 1].*pc(1,:),2.5*[-1 1].*pc(1,:));
    annotation('textarrow',figx,figy, 'String', '$p_1$',...
             'Color',[234/256 170/256 0],'Interpreter','latex','FontSize',6,'Headlength',5,'HeadWidth',4)
    [figx figy] = dsxy2figxy(2.5*[1 1].*pc(2,:),2.5*[-1 -1].*pc(2,:));
    annotation('textarrow',figx,figy, 'String', '$p_2$',...
             'Color',[234/256 170/256 0],'Interpreter','latex','FontSize',6,'Headlength',5,'HeadWidth',4)
   

 
    printFigure(hFigureHandle, cOutputFilePath)
end

function [x, pc] = generateSampleData ()

    iNum    = 512;
    rng(12);
    x(1,:)  = randn(1,iNum)-.5;
    x(2,:)  = 3*x(1,:)+(randn(1,iNum));

    for (i = 1:2)
        x(i,:) = (x(i,:)-mean(x(i,:)))./std(x(i,:));
    end
    x = x';
    [pc] = pca(x);
end