
fileFolder = '.\Sinograms\';
dirOutput = dir(fullfile(fileFolder,'*.tif')); % pattern to match filenames.

fileNames = {dirOutput.name};
fileNames = natsort(fileNames);
fileNames = string(fileNames);

% Exporting folder - Create destination filename
destinationFolder = '.\Centered Sinograms';
if ~exist(destinationFolder, 'dir')
  mkdir(destinationFolder);
end

czx = size(fileNames);
cxy = czx(2);


% Read and show the image in the middle
img0 = fullfile(fileFolder,fileNames(round(cxy)));
im = imread(img0);
imshow(img0);

% Image dimensions
 img_size = size(im);
 img_size_x = img_size(2);
 img_size_y = img_size(1);
 
% To select the edges of Sinogram
disp('Select left border');
[x_l,y_l] = ginput(1);
hold on
line([x_l x_l],[0 img_size_y],'color','r')

disp('Select right border');
[x_r,y_r] = ginput(1);
line([x_r x_r],[0 img_size_y],'color','b')

% Left offset
lo = x_l;
% Right offset
ro = abs(x_r-img_size_x);

if lo>ro
    A_cr = round(abs(ro-lo));
    B_cr = 0;
    C_cr = (img_size_x-round(abs(ro-lo)));
    D_cr = img_size_y;
else
    A_cr = 0;
    B_cr = 0;
    C_cr = (img_size_x-round(abs(ro-lo)));
    D_cr = img_size_y;
end 


%%
disp('Progressing. please wait');

for jj = 1:cxy
%    F = fileNames(jj)
   F = fullfile(fileFolder,fileNames(jj));
   im = imread(F);
   im = imcrop(im,[A_cr B_cr C_cr D_cr]);

   
baseFileName = sprintf('Centered Sinogram %d.tif', jj);
fullFileName = fullfile(destinationFolder, baseFileName);
imwrite(im, fullFileName);

end
disp('Done.');
