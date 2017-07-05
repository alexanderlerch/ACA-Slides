function displayPitchChroma()

    hFigureHandle = generateFigure(12,5);
    
    if(exist('ComputeFeature') ~=2)
        error('Please add the ACA scripts (https://github.com/alexanderlerch/ACA-Code) to your path!');
    end
    [cPath, cName]  = fileparts(mfilename('fullpath'));
    cOutputFilePath = [cPath '/../graph/' strrep(cName, 'display', '')];

    cFeatureNames = char('SpectralPitchChroma');

    % read sample data
    [x,fs]  = audioread([cPath '/../audio/sax_example.wav']);
    x       = x/max(abs(x));
    [v, t]  = ComputeFeature (deblank(cFeatureNames), x, fs);
    imagesc(t,0:11,v),colorbar
    set(gca,'YDir','normal','YTickLabel',{'C', 'D', 'E', 'F\#', 'G\#', 'A\#'})
    xlabel('$t$ [s]')
    ylabel('pitch class')

    printFigure(hFigureHandle, cOutputFilePath)
end