function printFigure(hFigureHandle, cOutputFilePath)

   print(hFigureHandle, '-depsc', '-tiff', '-r600', '-cmyk', strcat(cOutputFilePath,'.eps'));
   [a,b] = system(sprintf('epstopdf --gsopt=-dPDFSETTINGS=/prepress --outfile=%s.pdf %s.eps',cOutputFilePath,cOutputFilePath));
end