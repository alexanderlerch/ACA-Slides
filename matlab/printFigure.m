function printFigure(hFigureHandle, cOutputFilePath)
   print(hFigureHandle, '-depsc', '-tiff', '-r600', '-cmyk', strcat(cOutputFilePath,'.eps'));
   [a,b] = system(sprintf('epstopdf --gsopt=-dPDFSETTINGS=/prepress --outfile=%s.pdf %s.eps',cOutputFilePath,cOutputFilePath));
   if (~isempty(b))
       warning('printFigure: eps to pdf conversion failed... ("%s")\n esp2pdf message: "%s"',cOutputFilePath,b);
   end
end