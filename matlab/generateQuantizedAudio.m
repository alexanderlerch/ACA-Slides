function generateQuantizedAudio()
    [cPath, cName]  = fileparts(mfilename('fullpath'));
    cOutputFilePath = [cPath '/../audio/quantized_'];

    [x,fs]          = audioread([cPath '/../audio/sax_example.wav']);
    x               = x/max(abs(x));
    wordLength      = [16 12 8 4 2];
    
    for (i = 1:length(wordLength))
        xq = quantizeAudio(x,wordLength(i));
        
        % it's only emulated; write it in 16 bit anyway
        audiowrite([cOutputFilePath num2str(wordLength(i)) '.wav'],xq,fs);
    end
end