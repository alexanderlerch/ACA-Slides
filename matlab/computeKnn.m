function [ClassIdx] = computeKnn(TestFeatureVector, TrainFeatureMatrix, TrainClassIndices, k)
    
    if (nargin < 4)
        k = 3;
    end
    
    d           = pdist2(TestFeatureVector, TrainFeatureMatrix,'euclidean');
    [ds,idx]    = sort(d); 
    ClassIdx    = mode(TrainClassIndices(idx(1:k)));
end
