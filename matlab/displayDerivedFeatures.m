function displayDerivedFeatures()

    if(exist('ComputeFeature') ~=2)
        error('Please add the ACA scripts (https://github.com/alexanderlerch/ACA-Code) to your path!');
    end

    hFigureHandle = generateFigure(8,6.8);
    
    iStart  = 1;
    iLength = 2^17;
    
    [cPath, cName]  = fileparts(mfilename('fullpath'));
    cOutputFilePath = [cPath '/../graph/' strrep(cName, 'display', '')];

    cFeatureNames = char('SpectralCentroid');

    % read sample data
    [cPath, cName]  = fileparts(mfilename('fullpath'));
    [x,fs]  = audioread([cPath '/../audio/sax_example.wav'],[iStart iStart+iLength-1]);
    t       = linspace(0,(length(x)-1)/fs,length(x));
    x       = x/max(abs(x));
 
    alpha   = .8;
    [v, tv]         = ComputeFeature (deblank(cFeatureNames), x, fs);

    dv  = diff([v 0]);
    vlp = filter((1-alpha), [1 -alpha],v);

    subplot(311), 
    plot(tv,v),
    axis([tv(1) tv(end) 0 1200])
    ylabel('$v(t)$')
    set(gca,'XTickLabel',[],'YTickLabel',[])

    subplot(312)
    plot(tv,dv),
    axis([tv(1) tv(end) min(dv) max(dv)])
    ylabel('$v_\Delta(t)$')
    set(gca,'XTickLabel',[],'YTickLabel',[])

    subplot(313)
    plot(tv,vlp),
    axis([tv(1) tv(end) min(vlp) max(vlp)])
    set(gca,'XTickLabel',[],'YTickLabel',[])
    ylabel('$v_\mathrm{LP}(t)$')
    xlabel('$t$')

    printFigure(hFigureHandle, cOutputFilePath)
end