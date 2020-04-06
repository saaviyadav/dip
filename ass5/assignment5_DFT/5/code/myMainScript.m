%% MyMainScript
clear;
im = double(imread('../data/barbara256-part.png'));
im_s = double(imread('../data/stream.png'));
im_s = im_s(1:128,1:128);
im1 = im+20*randn(size(im));
im_s1 = im_s+20*randn(size(im_s));
%% Your code here
tic;
patch = 7;
imPCA = myPCADenoising(im1,patch,400);
rm_PCA = RMSE(im,imPCA);
figure;
imshow(imPCA,[]);
title('PCA Denoising');

im_sPCA = myPCADenoising(im_s1,patch,400);
rm_sPCA = RMSE(im_s,im_sPCA);
figure;
imshow(im_sPCA,[]);
title('PCA Denoising-stream');
toc;
%%
tic;
patch = 7;
imPCA2 = myPCADenoising2(im1,patch,20);
rm_PCA2 = RMSE(im,imPCA2);
toc;
figure;
imshow(imPCA2,[]);
title('PCA Denoising 2');

tic;
im_sPCA2 = myPCADenoising2(im_s1,patch,20);
rm_sPCA2 = RMSE(im_s,im_sPCA2);
figure;
imshow(im_sPCA2,[]);
title('PCA Denoising 2- stream');
toc;
%%
tic;
[~,filtered,~] = myBilateralFiltering(im1,1,49);
rm_BIL = RMSE(im1,filtered);
figure;
imshow(filtered,[]);
title('Bilateral Filtering');

toc;
%%
tic;
patch = 7;
J = (poissrnd(im)+3/8).^0.5;
im_po = myPCADenoising2(J,patch,0.5);
im_po = im_po.^2 - 3/8;
rm_po = RMSE(im,im_po);
figure;
imshow(im_po,[]);
title('Poisson Correction');
toc;
%%
tic;
patch = 7;
J_m = (poissrnd(im/20)+3/8).^0.5;
im_mpo = myPCADenoising2(J_m,patch,0.5);
im_mpo = im_mpo.^2 - 3/8;
rm_mpo = RMSE(im,im_mpo);
figure;
imshow(im_mpo,[]);
title('Poisson Correction(im/20)');
toc;
%%
tic;
imc = im1;
imc(im1(:)>255) = 255;
imc(im1(:)<0) = 0;
patch = 7;
im_cut = myPCADenoising(imc,patch,400);
rm_cut = RMSE(im,im_cut);

figure;
imshow(im_cut,[]);
title('Clamping intensity values');
toc;