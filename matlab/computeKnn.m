function [ClassIdx] = computeKnn(TestFeatureVector, TrainFeatureMatrix, TrainClassIndices, k)
    
    if (nargin < 4)
        k = 3;
    end
    
    d           = computeEucDist(TestFeatureVector, TrainFeatureMatrix);
    [ds,idx]    = sort(d); 
    ClassIdx    = mode(TrainClassIndices(idx(1:k)));
end

function d = computeEucDist( A, B )
    d = sqrt(sum(A.^2, 2) * ones(1,size(B,1))  - 2*A*B' + ones(size(A,1),1) * sum(B.^2, 2)');
end
