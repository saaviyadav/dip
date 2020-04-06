%% MyMainScript
clear;
img = load('../data/image_low_frequency_noise.mat');
Z = img.Z;
tic;
%% Your code here
FZ = fftshift(fft2(Z));
lFZ = log(abs(FZ)+1);
daspect([1 1 1]);
imagesc(lFZ);
title('Log Fourier transform');
axis tight;
colormap('jet');
x_max = [119;139];
y_max = [124;135];
k = 3;

not = FZ(:,:);
for i = 1:length(x_max)
    x = x_max(i);
    y = y_max(i);
    not(x-k:x+k,y-k:y+k) = 0;
end
figure;
daspect([1 1 1]);
imagesc(log(abs(not)+1));
title('Log Fourier transform after applying Notch filter');
axis tight;
colormap('jet');

Z1 = ifft2(ifftshift(not));
figure;
imagesc(abs(Z1));
title('Restored image');
daspect([1 1 1]);
axis tight;
colormap('gray');
toc;
