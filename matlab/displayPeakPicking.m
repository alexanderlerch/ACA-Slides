function displayPeakPicking()

    hFigureHandle = generateFigure(12,6.8);
    
    if(exist('ComputeNoveltyFunction') ~=2)
        error('Please add the ACA scripts (https://github.com/alexanderlerch/ACA-Code) to your path!');
    end
   
    iStart  = 1;
    iLength = 280000;
    
    [cPath, cName]  = fileparts(mfilename('fullpath'));
    cOutputFilePath = [cPath '/../graph/' strrep(cName, 'display', '')];
 
    % generate sample data
    [tx,x,tv,v,td,d,tg,g,onsetidx] = generateSampleData([cPath '/../audio/sax_example.wav'], [iStart iStart+iLength-1]);

    subplot(211),
    hold on;
    plot(tx,abs(x),'Color',.8*[1 1 1]);
    plot(tv,v);
    hold off;
    ylabel('Envelope')
    axis([tx(1) tx(end) 0 1.01])
    
    subplot(212),
    plot(td,d)
    hold on;
    plot(tg,g(1,:))
    plot(tg,g(2,:),'Color',.8*[1 1 1])
    stem(td(onsetidx),d(onsetidx),'filled');
    hold off;
    xlabel('$t$ [s]')
    legend('novelty','threshold','onsets')
    axis([td(1) td(end) 0 max(d)*1.01])
    
    printFigure(hFigureHandle, cOutputFilePath)
end

function [tx,x,tv,v,td,d,tg,g,onsetidx] = generateSampleData(cFilePath, aiIndices)

    iBlockLength= 4096;
    iHopLength  = 512;
    [x, fs]     = audioread(cFilePath, aiIndices);
    tx          = linspace(0,(aiIndices(2)-1)/fs,aiIndices(2));
    x           = x/max(abs(x));
    
    [d, td]     = ComputeNoveltyFunction ('Flux', x, fs, hann(iBlockLength,'periodic'), iBlockLength, iHopLength);
    [v, tv]     = ComputeFeature ('TimePeakEnvelope', x, fs, hann(iBlockLength,'periodic'), iBlockLength, iHopLength);
    v           = 10.^(v(1,:)*.05);
    
    iFiltLen    = 25;
    fOffset     = 1e-6;
    g           = filtfilt(ones(iFiltLen,1)/iFiltLen,1,d)+fOffset;
    g(2,:)      = 1e-5;
    tg          = td;
    
    [dummy,onsetidx] = findpeaks(max(0,d-g(1,:)));
    
end
