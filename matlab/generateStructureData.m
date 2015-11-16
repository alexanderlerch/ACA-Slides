function [tv,pcd,mfcc,pc,acf,parts] = generateStructureData(cFilePath)
    iBlockLength = 32768;

    [x, fs]     = audioread(cFilePath);
    [rms, tv]   = ComputeFeature ('TimeRms', x, fs, hann(iBlockLength), iBlockLength, iBlockLength/2);
    [mfcc, tv]  = ComputeFeature ('SpectralMfccs', x, fs, hann(iBlockLength), iBlockLength, iBlockLength/2);
    [pc, tv]    = ComputeFeature ('SpectralPitchChroma', x, fs, hann(iBlockLength), iBlockLength, iBlockLength/2);
    [acf, tv]   = FeatureTimeAcfCoeff(x, iBlockLength, iBlockLength/2, fs, (1:4:800));
    
    %norm
    mfcc = (mfcc(2:end,:)-repmat(min(mfcc(2:end,:),[],2),1,size(mfcc,2)))./repmat(max(mfcc(2:end,:),[],2)-min(mfcc(2:end,:),[],2),1,size(mfcc,2));
    acf  = (acf(2:end,:)-repmat(min(acf(2:end,:),[],2),1,size(acf,2)))./repmat(max(acf(2:end,:),[],2)-min(acf(2:end,:),[],2),1,size(acf,2));
    rms  = (rms+50)/(max(rms+50));
    rms(rms<0) = 0;
    
    pcd  = diff([zeros(12,1) pc],1, 2);
    %pcd  = (pcd-min(min(pcd)));
    pcd(pcd<0) = 0;
    pcd  = (pcd/max(max(pcd)));
    %pcd  = (pc-repmat(min(pcd,[],2),1,size(pcd,2)))./repmat(max(pcd,[],2)-min(pcd,[],2),1,size(pcd,2));
    
    mfcc    = mfcc.*repmat(rms,size(mfcc,1),1);
    pc      = pc.*repmat(rms,size(pc,1),1);
    acf     = acf.*repmat(rms,size(acf,1),1);
    mfcc    = mfcc/max(max(mfcc));
    pc      = pc/max(max(pc));
    acf     = acf/max(max(acf));

    parts = [1  1.612	34.229
            2   34.229	78.073	
            1   78.073	110.370
            2   110.370	142.624
            2   142.624	179.500];
%     parts = [1  1.612	34.229
%             2   34.229	76.073	
%             1   76.073	110.370
%             2   110.370	154.624
%             2   142.624	179.500];
end