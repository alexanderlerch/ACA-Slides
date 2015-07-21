function displayScatter(cDatasetPath)

    if (nargin<1)
        % this script is written for the GTZAN music/speech dataset
        cDatasetPath = 'c:\dataset\music_speech\'; 
    end
    if (exist('ComputeFeature') ~= 2)
        error('Please add the ACA scripts (https://github.com/alexanderlerch/ACA-Code) to your path!');
    end
    if ((exist([cDatasetPath 'music']) ~= 7) || (exist([cDatasetPath 'speech']) ~= 7))
        error('Dataset path wrong or does not contain music/speech folders!')
    end
    
    [cPath, cName]  = fileparts(mfilename('fullpath'));
    cOutputFilePath = [cPath '/../graph/' strrep(cName, 'display', '')];
    hFigureHandle   = generateFigure(7,6);

    % read music data
    music_files     = dir([cDatasetPath 'music/*.au']);
    speech_files    = dir([cDatasetPath 'speech/*.au']);
 
    v_music         = zeros(2,size(music_files,1));
    v_speech        = zeros(2,size(speech_files,1)); 
    
    % assuming the same number of files in both directories....
    for (i=1:size(music_files,1))
        v_music(:,i)    = ExtractFeaturesFromFile([cDatasetPath 'music/' music_files(i).name]);
        v_speech(:,i)   = ExtractFeaturesFromFile([cDatasetPath 'speech/' speech_files(i).name]);
    end
    
    iMarkerSize = 8;
    scatter(v_music(1,:),v_music(2,:), iMarkerSize,[0 0 0],'filled','o');
    axis square;
    xlabel('mean spectral centroid')
    ylabel('std rms')
    set(gca,'XTickLabel',[],'YTickLabel',[]);
    hold on;
    scatter(v_speech(1,:),v_speech(2,:), iMarkerSize,[.6 .6 .6],'filled','o');
    legend('music','speech','Location','NorthWest')

    printFigure(hFigureHandle, cOutputFilePath);

    scatter(500,550, iMarkerSize*3,[234/256 170/256 0],'filled','o');
    text(1500, 1000,'$\Rightarrow$ identify class')
    text(1500, 900,'of nearest point')
    hold off;
    printFigure(hFigureHandle, [cOutputFilePath '-nn']);
    
end

function [v] = ExtractFeaturesFromFile(cFilePath)

    cFeatureNames = char('SpectralCentroid',...
    'TimeRms');

    [x,fs]  = audioread(cFilePath);
    x       = x/max(abs(x));
    [X,f,tf]= spectrogram(x, hann(2048,'periodic'),1024,2048,fs);
    
    feature = ComputeFeature (deblank(cFeatureNames(1,:)), x, fs);
    v(1,1)    = mean(feature);
    
    feature = ComputeFeature (deblank(cFeatureNames(1,:)), x, fs);
    v(2,1)    = std(feature);
end