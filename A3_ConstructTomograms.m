

% fileFolder = '.\Sinograms';
fileFolder = '.\Centered Sinograms\';
dirOutput = dir(fullfile(fileFolder,'*.tif')); % pattern to match filenames.

% to sort the structure by names
fileNames = {dirOutput.name};
fileNames = natsort(fileNames);
fileNames = string(fileNames);


% Exporting folder - Create destination filename
destinationFolder = '.\Tomograms';
if ~exist(destinationFolder, 'dir')
  mkdir(destinationFolder);
end


%%
czx = size(fileNames);
cxy = czx(2);

for jj = 1:cxy
%    F = fileNames(jj)
   F = fullfile(fileFolder,fileNames(jj));
   
   im = imread(F);
   im = imrotate(im,270);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%% convert to B&W
   gr = im2gray(im);
% REVERSE the colors
   gr = imcomplement(gr);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Crop the image to 360
   sz = size(gr);
   xsz = sz(2);
   ysz = sz(1);
   gr = imcrop(gr,[0 0 xsz ysz]);

   grr =  im2double(gr); % to convert to double


   grrS = imresize(gr, [2000 360]);

I1 = iradon(grrS,1);
   
baseFileName = sprintf('Tomograms %d.tif', jj);
fullFileName = fullfile(destinationFolder, baseFileName);
imwrite(I1, fullFileName);

end
