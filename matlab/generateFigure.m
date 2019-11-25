function hFigureHandle = generateFigure(fWidthInCm, fHeightInCm)
    
    % dimension & location
    fMaxHeight  = 6.8;
    fMaxWidth   = 14;
    fPaperPos   = [0 0];
    
    % layout
    iFontSize       = 7;
    cFontName       = 'Helvetica';
    cInterpreter    = 'latex';
    iPlotLineWidth  = 1.3;    
    
    if (nargin < 2)
        fHeightInCm  = fMaxHeight;
        if (nargin < 1)
           fWidthInCm = fMaxWidth;
        end
    end
    
    fHeightInCm = min(fHeightInCm, fMaxHeight);
    fWidthInCm  = min(fWidthInCm, fMaxWidth);
    
    hFigureHandle = figure('Color', 'w');
    
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
    
    set(hFigureHandle,'PaperUnits', 'centimeters', 'PaperPosition', [fPaperPos fWidthInCm fHeightInCm]);    
    set(hFigureHandle,'Units', 'centimeters', 'Position', [[5 5] fWidthInCm fHeightInCm]);    
    
    % change default appearance
    set(hFigureHandle,'defaultAxesColorOrder',myColorMap); 
    set(hFigureHandle,'defaultAxesFontName', cFontName);
    set(hFigureHandle,'defaultAxesFontSize', iFontSize);
    set(hFigureHandle,'defaultTextFontname', cFontName);
    set(hFigureHandle,'defaultTextFontSize', iFontSize);
    set(hFigureHandle,'defaultLineLineWidth',iPlotLineWidth);
    set(hFigureHandle,'defaultTextInterpreter',cInterpreter);
    set(hFigureHandle,'defaultLegendInterpreter',cInterpreter)
    set(hFigureHandle,'defaultAxesTickLabelInterpreter',cInterpreter)
    set(hFigureHandle,'defaultAxesXGrid','on');
    set(hFigureHandle,'defaultAxesYGrid','on');
end