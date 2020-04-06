%% MyMainScript
Z = imread('../data/barbara256.png');
tic;
%% Your code here
[m,n] = size(Z);
%img = padarray(Z,[m/2,n/2]);
FZ = fftshift(fft2(Z));

D = [40 80];
[ideal_filt_40, abs_ideal_40] = idealLow(FZ,D(1));
figure;
imagesc(uint8(abs(ideal_filt_40))), title('Ideal Low Pass Filter with D=40'), axis image,colormap(gray(256));
figure;
imagesc(uint8(abs_ideal_40)), title('Frequency Response(Ideal Low Pass Filter, D=40)'), axis image,colormap(gray(256));

[ideal_filt_80, abs_ideal_80] = idealLow(FZ,D(2));
figure;
imagesc(uint8(abs(ideal_filt_80))), title('Ideal Low Pass Filter with D=80'), axis image,colormap(gray(256));
figure;
imagesc(uint8(abs_ideal_80)), title('Frequency Response(Ideal Low Pass Filter, D=80)'), axis image,colormap(gray(256));

toc;
%% Gaussian Low Pass
[gauss_40, abs_gauss_40] = GaussFilter(FZ,D(1).^2);
figure;
imagesc(uint8(abs(gauss_40))), title('Gaussian Filter with D=40'), axis image,colormap(gray(256));
figure;
imagesc(abs_gauss_40, [min(min(abs_gauss_40)) max(max(abs_gauss_40))]); colormap(jet); axis image, colorbar, title('Frequency Response(Gaussian Filter, D=40)');

[gauss_80, abs_gauss_80] = GaussFilter(FZ,D(2).^2);
figure;
imagesc(uint8(abs(gauss_80))), title('Gaussian Filter with D=80'), axis image,colormap(gray(256));
figure;
imagesc(abs_gauss_80, [min(min(abs_gauss_80)) max(max(abs_gauss_80))]); colormap(jet); axis image, colorbar, title('Frequency Response(Gaussian Filter, D=80)');
