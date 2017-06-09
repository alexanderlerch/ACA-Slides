function displayLogEpsilon()

    hFigureHandle = generateFigure(128,4);
    
    [cPath, cName]  = fileparts(mfilename('fullpath'));
    cOutputFilePath = [cPath '/../graph/' strrep(cName, 'display', '')];

    fLowerBound     = 0.01;
    fUpperBound     = 1;
    iNumValues      = 16384;
    fEpsilon        = [0.1 0.01 0.001 0.0001];
    fMagnitude      = linspace (fUpperBound, fLowerBound, iNumValues);

    fMagIndB     = 20*log10(fMagnitude);
    for (i=1:size(fEpsilon, 2))
        fError(i,:) = 20*log10(fMagnitude + fEpsilon(i)) - fMagIndB;
    end

    % plot data
    plot (fMagIndB, fError(1,:),'k:',...
        fMagIndB, fError(2,:),'k-.',...
        fMagIndB, fError(3,:),'k--',...
        fMagIndB, fError(4,:),'k-');

    % data formatting
    axis([fMagIndB(end) fMagIndB(1) -.5 20]);
    % add legend
    lh = legend(['$\epsilon = ' num2str(fEpsilon(1)','%1.0e') '$'],...
        ['$\epsilon = ' num2str(fEpsilon(2)','%1.0e') '$'],...
        ['$\epsilon = ' num2str(fEpsilon(3)','%1.0e') '$'],...
        ['$\epsilon = ' num2str(fEpsilon(4)','%1.0e') '$']);
    set(lh, 'Interpreter','latex');
    xlabel('$v_\mathrm{dB}$ [dB]');
    ylabel('$v''_\mathrm{dB}-v_\mathrm{dB}$ [dB]');

    printFigure(hFigureHandle, cOutputFilePath)

end
