clear; clc;
%% MyMainScript
img1 = load('../data/barbara.mat'); img1 = img1.imageOrig;
img2 = imread('../data/honeyCombReal.png');
img3 = imread('../data/grass.png');
test = imread('../data/test.jpeg');
img1 = uint8(img1(1:2:end,1:2:end));
img2 = uint8(img2(1:2:end,1:2:end));
tic;
%% Your code here
img = rgb2gray(test);
[corrupted, filtered,den] = myPatchBasedFiltering(img1, 8, 0.9*60);
rmsd = sqrt((1/(size(img1,1)*size(img1,2)))*(sum(sum((uint8(img1)-filtered).*(uint8(img1)-filtered)))))
%%
figure(1);
subplot(1,3,1);

imshow(uint8(img1),[]);
title('Original');colorbar;
subplot(1,3,2);
imshow(uint8(corrupted),[]);
title('Corrupted');colorbar;
subplot(1,3,3);
imshow(filtered,[]); % phantom is a popular test image
title('Filtered');colorbar;
%% 
figure(2);
imshow(uint8(den)); % phantom is a popular test image
title('Spacial Mask'); colorbar;
%%
[corrupted, filtered,den] = myPatchBasedFiltering(img2, 0.9, 0.9*255);
rmsd = sqrt((1/(size(img2,1)*size(img2,2)))*(sum(sum((uint8(img2)-filtered).*(uint8(img2)-filtered)))))
%%
figure(3);
subplot(1,3,1);

imshow(uint8(img2),[]);
title('Original');colorbar;
subplot(1,3,2);
imshow(uint8(corrupted),[]);
title('Corrupted');colorbar;
subplot(1,3,3);
imshow(filtered,[]); % phantom is a popular test image
title('Filtered');colorbar;
%%
figure(4);
imshow(uint8(den),[]);
title('Spacial Mask'); colorbar;
%%
[corrupted, filtered,den] = myPatchBasedFiltering(img3, 0.9, 0.81*255*1.1);
rmsd = sqrt((1/(size(img3,1)*size(img3,2)))*(sum(sum((uint8(img3)-filtered).*(uint8(img3)-filtered)))))
%%
figure(5);
subplot(1,3,1);

imshow(uint8(img3),[]);
title('Original');colorbar;
subplot(1,3,2);
imshow(uint8(corrupted),[]);
title('Corrupted');colorbar;
subplot(1,3,3);
imshow(filtered,[]); % phantom is a popular test image4.9320

title('Filtered');colorbar;
%%
figure(6);
imshow(uint8(den),[]);
title('Spacial Mask'); colorbar;