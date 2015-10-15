function displayPca()

    addpath(fullfile(docroot,'techdoc','creating_plots','examples'))

    hFigureHandle   = generateFigure(10.8,6);
    
    [cPath, cName]  = fileparts(mfilename('fullpath'));
    cOutputFilePath = [cPath '/../graph/' strrep(cName, 'display', '')];
 
    % generate sample data
    [c1, c2,c3,stat1,stat2,stat3] = generateSampleData ();

    iMarkerSize = 8;
    subplot(221);
    scatter(c1(:,1),c1(:,2), iMarkerSize,[0 0 0],'filled','o');
    hold on;
    scatter(c2(:,1),c2(:,2), iMarkerSize,[0 0 1],'filled','o');
    scatter(c3(:,1),c3(:,2), iMarkerSize,[234/256 170/256 0],'filled','o');
    hold off;
    set(gca,'XTickLabel',[],'YTickLabel',[]);

    subplot(222);
    res = 0.1;

    R = max([stat1(2,:) stat2(2,:) stat3(2,:)])*4;
    [x, y] = meshgrid(-R:res:R, -R+1:res:R-1);

    G1 = mvnpdf([x(:) y(:)],stat1(1,:),stat1(2:3,:));
    G1 = reshape(G1,size(x));
    contour( x, y, G1,[.01 .01],'k');
    hold on;

    G2 = mvnpdf([x(:) y(:)],stat2(1,:),stat2(2:3,:));
    G2 = reshape(G2,size(x));
    contour( x, y, G2,[.01 .01],'b');


    G3 = mvnpdf([x(:) y(:)],stat3(1,:),stat3(2:3,:));
    G3 = reshape(G3,size(x));
    contour( x, y, G3,[.01 .01],'Color',[234/256 170/256 0]);
    hold off;
    axis([-5 5 -20 20])
    set(gca,'XTickLabel',[],'YTickLabel',[]);

    subplot(212)
    mesh(x,y,sqrt(G1+G2+G3)) % sqrt just for visualization
    axis([-5 5 -20 20 0 1])
    view(14,58)
    set(gca,'XTickLabel',[],'YTickLabel',[],'ZTickLabel',[]);
    set(gca,'visible','off');

    printFigure(hFigureHandle, cOutputFilePath)
end

function [c1, c2,c3,stat1,stat2,stat3] = generateSampleData ()

    iNum    = 512;
    rng(12);
    c1(:,1) = randn(iNum,1);
    c1(:,2) = 3*c1(:,1)+2*randn(iNum,1);
    stat1   = [mean(c1); cov(c1)];
    c2(:,1) = .4*randn(iNum,1)+1.5;
    c2(:,2) = .4*randn(iNum,1)+1.5;
    stat2   = [mean(c2); cov(c2)];
    c3(:,1) = .3*randn(iNum,1)-3;
    c3(:,2) = 3*randn(iNum,1)-3;
    stat3   = [mean(c3); cov(c3)];
end