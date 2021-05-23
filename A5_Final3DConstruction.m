% https://stackoverflow.com/questions/24573653/matlab-3d-dose-array-visualization
% https://uk.mathworks.com/help/matlab/visualize/techniques-for-visualizing-scalar-volume-data.html
%%
fileFolder = '.\Resized Tomograms\';
dirOutput = dir(fullfile(fileFolder,'*.tif')); % pattern to match filenames.
% to sort the structure by names
T = struct2table(dirOutput); % convert the struct array to a table
sortedT = sortrows(T, 'name'); % sort the table by 'DOB'
sortedS = table2struct(sortedT); % change it back to struct array if necessary


fileNames = {sortedS.name};
fileNames = natsort(fileNames);  %=========================
fileNames = fliplr(fileNames);   % <==== Revrese the order!
fileNames = string(fileNames);   %=========================
%%
czx = size(fileNames);
cxy = czx(2);
Imatrix = []; 
for i=1:1:cxy
    
F = fullfile(fileFolder,fileNames(i));

images{i} = imread(F);
    
% images{i} = imread(sprintf('*.tif',i));
Imatrix = cat(3, Imatrix, images{i});

end

D = double(squeeze(Imatrix));
Ds = (squeeze(Imatrix));

D(D==0)=nan;
h = slice(D, [], [], 1:size(D,3));
% set(h, 'EdgeColor','interp', 'FaceColor','interp')
set(h, 'EdgeColor','none')
alpha(.05)


%          To adjust the aspect ratio of 3D plot
daspect([1 1 0.8])    %                                    for Vid2


view(35,45) 
axis tight
xlabel( 'X' );
ylabel( 'Y' );
zlabel( 'Z' );
axis vis3d %axis VIS3D freezes aspect ratio properties to enable rotation of 3-D objects