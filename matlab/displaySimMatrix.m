function displaySimMatrix()

    if(exist('ComputeFeature') ~=2)
        error('Please add the ACA scripts (https://github.com/alexanderlerch/ACA-Code) to your path!');
    end
    
    hFigureHandle   = generateFigure(7,6);
    [cPath, cName]  = fileparts(mfilename('fullpath'));
    cOutputFilePath = [cPath '/../graph/' strrep(cName, 'display', '')];

    cFeatureNames = char('SpectralPitchChroma');

    % read sample data
    [cPath, cName]  = fileparts(mfilename('fullpath'));
    [x,fs]  = audioread([cPath '/../audio/excerpt_pop.mp3']);
    x       = x/max(abs(x));
 
    [v, tv] = ComputeFeature (deblank(cFeatureNames(1,:)), x, fs);

    D       = zeros(length(tv));
    for (i=1:length(tv))
        D(i,:)  = sqrt(sum((repmat(v(:,i),1,length(tv))-v).^2));
    end

    imagesc(tv,tv,D)
    c=colormap('jet');
    colormap(flipud(c));
    xlabel('lag')
    ylabel('lag')

    printFigure(hFigureHandle, cOutputFilePath)

end