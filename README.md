# CT-Scan-with-visible-light
I developed a shadow-based CT scan technique (using visible light instead of X-ray) to reconstruct 3D model of transparent objects. 
https://youtu.be/DClFSdOXJVw

First you need to save all the Matlab files in the same folder. There is also a folder called "vid" including your videos which should be saved in the same folder. There is already one video saved in the "vid" folder called "vid2.mp4" which you can use as an example.

You need to run the Matlab codes in the right order as follow:
1. "A1_ConstructSinogram.m"; In line 3 you can change the video you are processing (currently it is "vid2.mp4"). In line 7 and 8 you need to select your start and end frame respectively. Please note that the object should have a full 360 degree rotation with constant angular speed between start and end frame. 
After running this code an image of your video will pop open and you need to select the left border of the rotating object, the right border of the rotating object, the top border and the bottom of the scanned rotating object respectively. This is to ensure right ROI is selected. The scripts then start creating sinograms. This script also creates a subfolder called "Sinograms" and this is where all the sinograms are stored
2. "A2_CenteringSinograms.m"; It reads all the sinograms created in previous step and you need to perfectly centre them by clicking precisely at left border of the sinogram and then right border of the sinogram. This script then creates a subfolder called "Centered Sinograms" and this is where all the centered sinograms are stored.
3. "A3_ConstructTomograms.m"; It reads all the centered Singorams and calculate corresponding Tomograms. This scripts then creates a subfolder called "Tomograms" and this is where all the created Tomograms will be stored.
4. "A4_ResizeTomograms.m"; This script acts as a data reduction process the resize the created Tomograms for a faster processing. This script created a subfolder called "Resized Tomograms" and stores all the resized Tomograms in there.
5. "A5_Final3DConstruction.m"; This script created the CT slices and after completing this stage you can open "Volume Viewer" app to import and visualise your data.

