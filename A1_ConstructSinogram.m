
% To open the video file located in "vid" folder
obj=VideoReader('.\vid\vid2.mp4');
nFrames=obj.NumFrames;

% between which two frames the full 360 happens?
StartFrame = 60; 
EndFrame = 60+776;
LengthFrame = EndFrame-StartFrame;

% Exporting folder - Create destination filename
destinationFolder = '.\Sinograms';
if ~exist(destinationFolder, 'dir')
  mkdir(destinationFolder);
end

% Read and show the first frame
img0=read(obj,1);
imshow(img0);

% Image dimensions
 img_size = size(img0);
 img_size_x = img_size(2);
 img_size_y = img_size(1);
 
% To select the centre of rotation
disp('Select left border');
[x_1,y_1] = ginput(1);
hold on
disp('Select right border');
line([x_1 x_1],[0 img_size_y],'color','red');
[x_2,y_2] = ginput(1);
line([x_2 x_2],[0 img_size_y],'color','red');

x_centre = (x_1+x_2)/2;
y_centre = (y_1+y_2)/2;
line([x_centre x_centre],[0 img_size_y], 'linewidth',1,'color','red','LineStyle','--');

% To select the top horizontal crop line
disp('Select top border');
[xh_top,yh_top] = ginput(1);
line([0 img_size_x],[yh_top yh_top]);

% To select the bottom horizontal crop line
disp('Select bottom border');
[xh_bot,yh_bot] = ginput(1);
line([0 img_size_x],[yh_bot yh_bot]);

% To calculate the vertical crop lines - within 80% of center-line
pr = 0.7;
xv_left = x_centre - pr*(img_size_x/2);
xv_right = x_centre + pr*(img_size_x/2);
line([xv_left xv_left],[0 img_size_y]);
line([xv_right xv_right],[0 img_size_y]);

disp('Generating sinograms may take several minutes');

% Crop parameters
xl = xv_left; % x cordinate of left of frame
dx = xv_right-xv_left; % length in x direction
yt = yh_top; % y cordinate of top of frame
dy = abs(yh_top-yh_bot); % length in y direction



Sing = zeros(nFrames,dx,3);
Sing = uint8(Sing);

offset_y = 1;
frjmp = 1; %frame jump = every [frjmp] frame
cnt = 1;

for kk = 1:offset_y:dy

disp(append('Sinogram ',num2str(cnt),' of ',num2str(LengthFrame)))
    
i = 1; % Counter for image name
for k=1:frjmp:nFrames
  
    img=read(obj,k);
    img_crop = imcrop(img,[xl yt dx dy]);
    img_crop_sing = imcrop(img_crop,[0 (kk) (dx) 0]); % second crop
    
%     To write it into jpg images
%     ********************************
    Sing(i,:,:) = img_crop_sing;
    i = i+1;         
end

%crop to full 360 rotation:
Sing = imcrop(Sing,[0 StartFrame dx LengthFrame]);

baseFileName = sprintf('Sinogram %d.tif', kk);
fullFileName = fullfile(destinationFolder, baseFileName);
imwrite(Sing, fullFileName);

cnt = cnt+1;
end


