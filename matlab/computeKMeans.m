function [clusterIdx,state] = computeKMeans(fFeatureMatrix, K, numMaxIter, prevState)
    
    if (nargin < 3)
        numMaxIter  = 1000;
    end
    if (nargin == 4)
        state = prevState;
    else
        rng(7); % for being able to reproduce the plot
        state = updateState(fFeatureMatrix,...
            round(rand(1,size(fFeatureMatrix,2))*(K-1))+1, K);
    end
    range   = [min(fFeatureMatrix,[],2) max(fFeatureMatrix,[],2)];
    
    for i=1:numMaxIter
        clusterIdx  = assignClusterLabels(fFeatureMatrix,state);
        prevState   = state;
        state = updateState(fFeatureMatrix,clusterIdx,K);
        state = reinitState(state, clusterIdx, K, range);
        if (max(sum(abs(state.m-prevState.m)))==0)
            break;
        end
    end
end

function [clusterIdx]  = assignClusterLabels(fFeatureMatrix,state)
    % compute distance to all points
    for (k=1:length(state.m))
        D(k,:) = sqrt(sum((repmat(state.m(:,k),1,size(fFeatureMatrix,2))-fFeatureMatrix).^2,1));
    end
    
    % assign to closest
    [dummy,clusterIdx] = min(D,[],1);
end

function [state] = updateState(fFeatureMatrix,clusterIdx,K)
    m = zeros(size(fFeatureMatrix,1), K);
    for (k=1:K)
        if~(isempty(find(clusterIdx==k)))
            m(:,k) = mean(fFeatureMatrix(:,find(clusterIdx==k)),2);
        end
    end
    state = struct('m',m);
end

function  [state] = reinitState(state, clusterIdx, K, range)
    for (k=1:K)
        if(isempty(find(clusterIdx==k)))
            state.m(:,k) = rand(size(state,1),1).*(range(:,2)-range(:,1)) + range(:,1);
        end
    end
end
