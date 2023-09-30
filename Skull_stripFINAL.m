clear all, close all

load('MRI_brain.mat');
I_norm=I_padded;

for ii = 1:40
    brain_image(:,:,ii)=skull_strip(I_norm(:,:,ii));
end

figure, im(brain_image), title('Skull Strip Matrix') 
figure, im(brain_image(:,:,25)), title ('Skull Strip Slice 25')
figure, im(I_norm-brain_image), title ('Difference Image Matrix')
figure, im(I_norm(:,:,25)-brain_image(:,:,25)), title ('Difference Image Slice 25)')


