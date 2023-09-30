function [image_out] = skull_strip(image_in,brain)
%skull stripped image
I_norm=image_in;

%Histogram to determine Threshold (T)
%figure, histogram(I_padded), set(gca, 'Yscale', 'log')
T=7900; 
BW=imbinarize(I_norm, T);

%Erode to increase brain/skull separation
se=strel('disk', 5);
I_erode=imerode(BW,se);
%Fill holes
I_fill=imfill(I_erode,'holes');
%Further erode non-brain structures
se1=strel('disk', 6);
I_erode1=imerode(I_fill,se1);
%Dilate to fill in any cropped brain
se3=strel('disk', 12);
I_dilate = imdilate(I_erode1, se3);

%Connected components blob determined using pixel area 
cc = bwconncomp(I_dilate,4); 
stats = regionprops(cc,"Area"); 
idx = find([stats.Area] > 5000); 
BW2 = ismember(labelmatrix(cc),idx);

%Apply final mask to original image
image_out=I_norm.*BW2; 

end