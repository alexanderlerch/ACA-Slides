function [tx,x,tv,pcd,mfcc,pc,acf,parts,labels] = generateStructureData(cFilePath)
    iBlockLength = 32768;
    
    [x, fs]     = audioread(cFilePath);
    x           = mean(x,2);
    x           = x/max(abs(x));
    tx          = (0:(length(x)-1))/fs;
    [rms, tv]   = ComputeFeature ('TimeRms', x, fs, hann(iBlockLength), iBlockLength, iBlockLength/2);
    [mfcc, tv]  = ComputeFeature ('SpectralMfccs', x, fs, hann(iBlockLength), iBlockLength, iBlockLength/2);
    [pc, tv]    = ComputeFeature ('SpectralPitchChroma', x, fs, hann(iBlockLength), iBlockLength, iBlockLength/2);
    [acf, tv]   = FeatureTimeAcfCoeff(x, iBlockLength, iBlockLength/2, fs, (1:4:800));
    
    %norm
    mfcc = (mfcc(2:end,:)-repmat(min(mfcc(2:end,:),[],2),1,size(mfcc,2)))./repmat(max(mfcc(2:end,:),[],2)-min(mfcc(2:end,:),[],2),1,size(mfcc,2));
    acf  = (acf(2:end,:)-repmat(min(acf(2:end,:),[],2),1,size(acf,2)))./repmat(max(acf(2:end,:),[],2)-min(acf(2:end,:),[],2),1,size(acf,2));
    rms  = (rms(1,:)+50)./(max(rms(1,:)+50));
    rms(rms<0) = 0;
    
    len = min([size(mfcc,2) size(acf,2) size(rms,2)]);
    mfcc = mfcc(1:size(len,2));
    acf = acf(1:size(len,2));
    rms = rms(1:size(len,2));
    
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

    [pathstr, name, ext] = fileparts(cFilePath);
    bounds = readtable([pathstr '/' name '.txt']);
    parts = [ bounds.Var1 bounds.Var2];

    labels = [];
    indices= zeros(size(parts,1),1);
    numparts = 1;
    for (k = 1:size(parts,1))
        prev = [];
        indices(k)  = numparts;
        
        if (k > 1)
            prev = find(ismember(bounds.Var4(1:k-1,:),bounds.Var4(k)));
        end    
        if isempty(prev)
            numparts    = numparts+1;
            prev        = k;
        else
            indices(k)  = prev(1);
        end
        if isempty(labels)
            labels = char(bounds.Var4(prev));
        else
            labels = char(labels,char(bounds.Var4(k)));
        end
    end
    
    parts = [indices parts];
%     parts = [1  1.612	34.229
%             2   34.229	78.073	
%             1   78.073	110.370
%             2   110.370	142.624
%             2   142.624	179.500];
%     parts = [1  1.612	34.229
%             2   34.229	76.073	
%             1   76.073	110.370
%             2   110.370	154.624
%             2   142.624	179.500];
end