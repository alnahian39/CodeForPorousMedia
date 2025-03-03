%Abdullah Al Nahian, April 2022
%example code to load image series and calculate porosity for CT images

clear all

%base of image file names
filebase = ('write_the_base');
fileend = ('.tif');

%to get names of files, fist provide the directory where the image sequence
%is located
dirName = 'write_the_folder_directory'; %folder path
files = dir(fullfile(dirName,'*.tif')); %list all .tif files in the above folder
files = {files.name}'; %create cell to store file names

data = cell(numel(files),1); %store file contents

%Get size of an individual image
imagefile1name = fullfile(dirName,files{1});
image1=imread(imagefile1name);
[rows, cols] = size(image1);

%voxel counters to get porosity
pores = 0;
grain = 0;
total = 0;

%create 3D matrix of data
CT3Ddata = zeros(rows,cols,numel(files));

numimages = numel(files); %total number of images in the folder

for m = 1:numel(files)
   
    imagefilename =fullfile(dirName,files{m});
    CTslice = imread(imagefilename);
    
%determine the number of pores, grains and total pixels
 for i=1:rows
    for j=1:cols
        if  CTslice(i,j)==0  %is pore
            pores = pores+1;
            total = total +1;
        else
            CTslice(i,j)= 255; %is grain
            grain = grain+1;
            total = total+1;
        end
        %create 3D binary matrix
        CT3Ddata(i,j,m) = CTslice(i,j);
    end
 end
end

%calculate porosity
porosity = pores/total;
