fileFolder = '.\Tomograms\';
dirOutput = dir(fullfile(fileFolder,'*.tif')); % pattern to match filenames.
% to sort the structure by names
T = struct2table(dirOutput); % convert the struct array to a table
sortedT = sortrows(T, 'date'); % sort the table by 'DOB'
sortedS = table2struct(sortedT); % change it back to struct array if necessary

% Exporting folder - Create destination filename
destinationFolder = '.\Resized Tomograms';
if ~exist(destinationFolder, 'dir')
  mkdir(destinationFolder);
end


fileNames = {sortedS.name};
fileNames = natsort(fileNames);
fileNames = string(fileNames);
     
czx = size(fileNames);
cxy = czx(2);
for ii = 1 :1: cxy

    F = fullfile(fileFolder,fileNames(ii));
%     F = fileNames(ii);
    currentimage = imread(F);

    img = currentimage;
    imgE = imadjustn(img,[0.1 0.7]);
    

    %%%%%%%%%%%%%%%%%  Reduce the resolution %%%%%%%%%%%%%%
    imgE = imresize(img, [320 NaN]);
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    baseFileName = sprintf('Resized Sinogram %d.tif', ii);
    fullFileName = fullfile(destinationFolder, baseFileName);
    imwrite(imgE, fullFileName);
    
    
end

