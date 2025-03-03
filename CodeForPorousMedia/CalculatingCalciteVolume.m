%Abdullah Al Nahian, December 2023
%example codes for calculating calcite in each image slice
 
clear all;

%get the image file from the folder
 
jpeg1 = dir('write_the_imagefile_location\*.tif');

%number of files in the folder
numfiles = length(jpeg1);
mydata = cell(1, numfiles);
 
 P=zeros(1,numfiles); %cosidering all grains and pores as pores other than calcite
 C=zeros(1,numfiles); %calcite
 CV = zeros(1,numfiles); %calcite volume
 
for k = 1:numfiles
    filename1 = strcat('write_the_imagefile_location\',jpeg1(k).name);
    
    I = imread(filename1);
   
 
    row = size(I,1);
    col = size(I,2);
    for i = 1:row;
        for j = 1:col;
            if  I(i,j)== 255
                P(1,k)=P(1,k)+1;
            else
                C(1,k)=C(1,k)+1;
                
            end
            %calculating volume fraction of the calcite in an image slice
            CV(1,k)=(C(1,k)/(P(1,k)+C(1,k)))*100;
 
        end
    end 
end
 
filename = (['Calcitefraction.txt']);
filename = fopen(filename,'wt');
fprintf(filename, 'Slice\t Total pore pixels\t Total calcite pixels\t Total calcite fractions\n');
k=1;
for k=1:numfiles;  
%% WRITE BELOW THE CORRECT OUTPUT FILE NAME
 
fprintf(filename, '%s\t %g\t %g\t %g\n', num2str(k), P(1,k), C(1,k),  CV(1,k));
 
end
fclose('all');
