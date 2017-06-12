function displayPerceptualPitch()

    hFigureHandle = generateFigure(10.8,5);
    
    [cPath, cName]  = fileparts(mfilename('fullpath'));
    cOutputFilePath = [cPath '/../graph/' strrep(cName, 'display', '')];
 
    % read sample data
    [x,y,z]  = generateSampleData();

    plot3(x,y,zeros(size(x)),'Color',[234/256 170/256 0]);
    hold on;
    plot3(x,y,z,'k')
    view(-38,32);
    set(gca,'XTick',[0 1])
    set(gca,'YTick',[0 1])
    zlabel('$f/f_0$');
    set(gca,'XTickLabel',{''})
    set(gca,'YTickLabel',{''})
    set(gca,'ZTick',[1 2 4 8 16])
    
    vec = (find( x - 1>-1e-5));
    plot3(x(vec),y(vec),z(vec),'o','MarkerEdgeColor','k',...
                'MarkerFaceColor','k',...
                'MarkerSize',5)
    
 
    cPitchNames = char('C','C\#','D','D\#','E','F','F\#','G','G\#','A','A\#','B');
    for (k = 1:12)
        phase = j*(k-1)*2*pi/12;
        text(real(.7*exp(phase)),imag(.8*exp(phase)),deblank(cPitchNames(k,:)),'Color',[234/256 170/256 0]);
    end
    hold off;

    axis('tight')

    printFigure(hFigureHandle, cOutputFilePath)
end

function [x,y,z] = generateSampleData()
    
    t= linspace(0,8*pi,16384);%0.00:0.01:8*pi;
    x=cos(t);
    y=sin(t);
    z = 2.^(t/(2*pi));
end