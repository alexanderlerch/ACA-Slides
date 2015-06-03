function displayPdfExamples()

    hFigureHandle = generateFigure(10.8,5);
    
    [cPath, cName]  = fileparts(mfilename('fullpath'));
    cOutputFilePath = [cPath '/../graph/' strrep(cName, 'display', '')];
 
    % generate sample data
    [x,pdf,cTitle] = generateSampleData();

    for ( i=1:size(pdf,1))
        subplot(2,2,i)
        plot(x,pdf(i,:))
        if (i==1)
            hold on
            stem(x(pdf(i,:)~=0),pdf(i, pdf(i,:)~=0), 'Marker', '^','MarkerFaceColor','k','MarkerEdgeColor','k','Color','k','MarkerSize',5)
            %stem(x(end),pdf(i,end-iAdd), 'k-', 'LineWidth', iPlotLineWidth, 'Marker', '^','MarkerFaceColor','k','MarkerSize',5)
            hold off
        end
        if (i>2)
            xlabel('x');
        end
        if (mod(i,2)==1)
            ylabel('p_x(x)');
        end

        title(deblank(cTitle(i,:)));

        % formatting stuff
        axis([x(1) x(end) 0 1.5])
        grid on 
    end
    printFigure(hFigureHandle, cOutputFilePath)
end

function [xpad, pdf, cTitle] = generateSampleData()

    fStepSize   = 1e-4;
    
    x           = -1:fStepSize:1;
    xpad        = (-1.1):fStepSize:(1.1);
    pdf         = zeros(4,length(x));
    pdf(1,:)    = [.5, zeros(1,length(x)-2), .5]; %rect
    pdf(2,:)    = 1./(pi*sqrt(1-x.^2)); %sine
    pdf(3,:)    = 1/2*ones(1,length(x)); %equal
    
    iPad        = (length(xpad)-length(x))/2;
    pdf         = [zeros(4,iPad) pdf zeros(4,iPad)];
    pdf(4,:)    = exp(-1/2*(xpad/.45).^2)/sqrt(2*pi*.45^2); %gauss
    
    cTitle      = char('Square', 'Sine', 'Uniform White Noise, Sawtooth', 'Gaussian Noise');
end