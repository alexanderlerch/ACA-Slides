function displayPcaExample()

    if (exist('ComputeFeature') ~= 2)
        error('Please add the ACA scripts (https://github.com/alexanderlerch/ACA-Code) to your path!');
    end

    hFigureHandle = generateFigure(12,5);
    
    [cPath, cName]  = fileparts(mfilename('fullpath'));
    cOutputFilePath = [cPath '/../graph/' strrep(cName, 'display', '')];
 
    % read sample data
    [x,fs] = audioread([cPath '/../audio/sax_example.wav']);
    x      = x/max(abs(x));
    cFeatureNames = char('SpectralCentroid','SpectralRolloff','SpectralSpread', 'TimeZeroCrossingRate','TimePeakEnvelope');

    v = [];
    for (i = 1:size(cFeatureNames,1))
        [tmp, t] = ComputeFeature (deblank(cFeatureNames(i,:)), x, fs);
        v = [v;tmp(:,1:500)];
    end
    %norm
    m = median(v,2);
    for (i = 1:size(v,1))
        v(i,:)  = v(i,:) - m(i);
        s       = sqrt(v(i,:)*v(i,:)'/length(v));
        v(i,:)  = v(i,:) / s;
    end
 
    plot(v'), grid on, legend(cFeatureNames)
    xlabel('$n$')
    ylabel('$v(n)$')
    axis([1 size(v,2) -4 10])
    printFigure(hFigureHandle, [cOutputFilePath '_input'])
    
    [coeff, score, latent, tsquare] = pca(v');
    
    plot(latent), grid on
    hold on; plot(ones(1,size(v,1)),'Color',[234/256 170/256 0]); hold off;
    xlabel('component')
    ylabel('eigenvalue')
    printFigure(hFigureHandle, [cOutputFilePath '_latent'])
    
    plot(score), grid on
    xlabel('$n$')
    ylabel('$pc(n)$')
    axis([1 size(v,2) -4 10])
    printFigure(hFigureHandle, [cOutputFilePath '_output'])

end
