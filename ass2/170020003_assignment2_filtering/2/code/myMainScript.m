%% MyMainScript
clear
img_mat = load('../data/barbara.mat');
img1 = uint8(img_mat.imageOrig);
img = imread('../data/honeyCombReal.png');
img3 = imread('../data/grass.png');
tic;


%% Your code here

true1 = 1.8*50*1.1;
true2 = 20*1.4*0.9*1.1;
[corrupted, filtered, mask] = myBilateralFiltering(img, true1, true2);

figure(1);
colormap(gray(256));
subplot(1,3,1);
imshow(img);
title('Original');colorbar;
subplot(1,3,2);
imshow(corrupted);
title('Corrupted');colorbar;
subplot(1,3,3);
imshow(filtered);
title('Filtered');colorbar;
%%
figure(2);
imshow(mask);
title('Mask'); colorbar;
RMSD1 = (sum(sum(((filtered - img).^2)))/(size(img,1)*size(img,2))).^0.5

% [corrupted, filtered,mask] = myBilateralFiltering(img, true1*1.1, true2);
% RMSD2 = (sum(sum(((filtered - img).^2)))/(size(img,1)*size(img,2))).^0.5
% 
% [corrupted, filtered, mask] = myBilateralFiltering(img, true1*0.9, true2);
% RMSD3 = (sum(sum(((filtered - img).^2)))/(size(img,1)*size(img,2))).^0.5
% 
% [corrupted, filtered, mask] = myBilateralFiltering(img, true1, true2*1.1);
% RMSD4 = (sum(sum(((filtered - img).^2)))/(size(img,1)*size(img,2))).^0.5
% 
% [corrupted, filtered, mask] = myBilateralFiltering(img, true1, true2*0.9);
% RMSD5 = (sum(sum(((filtered - img).^2)))/(size(img,1)*size(img,2))).^0.5



toc;
%%
true1 = 1.8*50;
true2 = 20;
[corrupted, filtered,mask] = myBilateralFiltering(img3, true1, true2);

figure(3);
colormap(gray(256));
subplot(1,3,1);
imshow(img3);
title('Original');colorbar;
subplot(1,3,2);
imshow(corrupted);
title('Corrupted');colorbar;
subplot(1,3,3);
imshow(filtered);
title('Filtered');colorbar;
RMSD1 = (sum(sum(((filtered - img3).^2)))/(size(img3,1)*size(img3,2))).^0.5
%%
figure(4);
imshow(mask);
title('Mask'); colorbar;

% [corrupted, filtered,mask] = myBilateralFiltering(img3, true1*1.1, true2);
% RMSD2 = (sum(sum(((filtered - img3).^2)))/(size(img3,1)*size(img3,2))).^0.5
% 
% [corrupted, filtered,mask] = myBilateralFiltering(img3, true1*0.9, true2);
% RMSD3 = (sum(sum(((filtered - img3).^2)))/(size(img3,1)*size(img3,2))).^0.5
% 
% [corrupted, filtered,mask] = myBilateralFiltering(img3, true1, true2*1.1);
% RMSD4 = (sum(sum(((filtered - img3).^2)))/(size(img3,1)*size(img3,2))).^0.5
% 
% [corrupted, filtered,mask] = myBilateralFiltering(img3, true1, true2*0.9);
% RMSD5 = (sum(sum(((filtered - img3).^2)))/(size(img3,1)*size(img3,2))).^0.5

%%
true1 = 1.8*50;
true2 = 20*0.9*0.9*0.9*0.9*0.9*0.9*0.9*0.9;
[corrupted, filtered,mask] = myBilateralFiltering(img1, true1, true2);

figure(5);
colormap(gray(256));
subplot(1,3,1);
imshow(img1,[]);
title('Original');colorbar;
subplot(1,3,2);
imshow(corrupted,[]);
title('Corrupted');colorbar;
subplot(1,3,3);
imshow(filtered,[]);
title('Filtered');colorbar;
RMSD1 = (sum(sum(((filtered - img1).^2)))/(size(img1,1)*size(img1,2))).^0.5
%%
figure(6);
imshow(mask);
title('Mask'); colorbar;
% [corrupted, filtered,mask] = myBilateralFiltering(img1, true1*1.1, true2);
% RMSD2 = (sum(sum(((filtered - img1).^2)))/(size(img1,1)*size(img1,2))).^0.5
% 
% [corrupted, filtered,mask] = myBilateralFiltering(img1, true1*0.9, true2);
% RMSD3 = (sum(sum(((filtered - img1).^2)))/(size(img1,1)*size(img1,2))).^0.5
% 
% [corrupted, filtered,mask] = myBilateralFiltering(img1, true1, true2*1.1);
% RMSD4 = (sum(sum(((filtered - img1).^2)))/(size(img1,1)*size(img1,2))).^0.5
% 
% [corrupted, filtered,mask] = myBilateralFiltering(img1, true1, true2*0.9);
% RMSD5 = (sum(sum(((filtered - img1).^2)))/(size(img1,1)*size(img1,2))).^0.5