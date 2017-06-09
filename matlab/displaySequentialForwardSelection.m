function displaySequentialForwardSelection(cDatasetPath)

    if (nargin<1)
        % this script is written for the GTZAN music/speech dataset
        % modify this path or use the function parameter to specify your
        % dataset path
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
    hFigureHandle   = generateFigure(10,4);

    iNumFeatures    = 88;
    
    % read music data
    music_files     = dir([cDatasetPath 'music/*.au']);
    speech_files    = dir([cDatasetPath 'speech/*.au']);
 
    v_music         = zeros(iNumFeatures,size(music_files,1));
    v_speech        = zeros(iNumFeatures,size(speech_files,1)); 
    
    % this may take a while...
    for (i=1:size(music_files,1))
        v_music(:,i)    = ExtractFeaturesFromFile([cDatasetPath 'music/' music_files(i).name]);
    end
    for (i=1:size(speech_files,1))
        v_speech(:,i)   = ExtractFeaturesFromFile([cDatasetPath 'speech/' speech_files(i).name]);
    end
    %load('c:/temp/fs');hFigureHandle   = generateFigure(10,4);
    
    v = [v_music,v_speech];
    m = mean(v,2);
    s = std(v,0,2);
    
    v     = (v - repmat(m,1,size(music_files,1)+size(speech_files,1)))./repmat(s,1,size(music_files,1)+size(speech_files,1));
    C     = [zeros(1,size(music_files,1)) ones(1,size(speech_files,1))];

    selectedFeatures    = [];
    remainingFeatures   = ones(1,iNumFeatures);
    maxAccuracy         = zeros(1,iNumFeatures);
    for (i = 1:iNumFeatures)
        acc                 = zeros(1,iNumFeatures);
        for f=1:iNumFeatures
            if (remainingFeatures(f) > 0)
                acc(f)  = LeaveOneOutCV(v([selectedFeatures f],:),C);
            else
                acc(f)  = -1;
                continue;
            end
        end
        [maxacc,maxidx]             = max(acc);
        selectedFeatures            = [selectedFeatures, maxidx];
        remainingFeatures(maxidx)   = 0;
        maxAccuracy(i)              = maxacc;
    end
    
    plot(maxAccuracy)
    xlabel('\# of Features')
    ylabel('classification accuracy')  
    axis([1 iNumFeatures 0.89 1.01])
    
    printFigure(hFigureHandle, cOutputFilePath);

end

function [v] = ExtractFeaturesFromFile(cFilePath)

cFeatureNames = char('SpectralCentroid',...
    'SpectralCrestFactor',...
    'SpectralDecrease',...
    'SpectralFlatness',...
    'SpectralFlux',...
    'SpectralKurtosis',...
    'SpectralMfccs',...
    'SpectralPitchChroma',...
    'SpectralRolloff',...
    'SpectralSkewness',...
    'SpectralSlope',...
    'SpectralSpread',...
    'SpectralTonalPowerRatio',...
    'TimeAcfCoeff',...
    'TimeMaxAcf',...
    'TimePeakEnvelope',...
    'TimePredictivityRatio',...
    'TimeRms',...
    'TimeStd',...
    'TimeZeroCrossingRate');

    [x,fs]  = audioread(cFilePath);
    x       = x/max(abs(x));
    [X,f,tf]= spectrogram(x, hann(2048,'periodic'),1024,2048,fs);
    
    v = [];
    for (i=1:size(cFeatureNames,1))
        feature = ComputeFeature (deblank(cFeatureNames(i,:)), x, fs);
        v       = [v;mean(feature,2); std(feature,0,2)];
    end
end

function [acc] = LeaveOneOutCV(v,C)
    TP      = 0;
    for i = 1:size(v,2)
        v_train = [v(:,1:i-1) v(:,i+1:end)]';
        C_train = [C(1:i-1) C(:,i+1:end)]';
        res = computeKnn(v(:,i)', v_train,C_train,3);
        if (res == C(i))
            TP = TP+1;
        end
    end
    
    acc = TP/length(C);
end