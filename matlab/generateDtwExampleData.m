function [seq1, seq2, D, p, C] = generateDtwExampleData(cFilePath1, cFilePath2)

    [seq1]      = audioread(cFilePath1);
    [seq2]      = audioread(cFilePath2);
    N           = length(seq2);
    M           = length(seq1);

    D           = (repmat(seq1(:),1,N)-repmat(seq2(:)',M,1))'.^2;

    [p, C]      = ToolSimpleDtw(D);    
end