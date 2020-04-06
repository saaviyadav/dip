%% MyMainScript
clear;
clc;
img1 = imread('../data/bird.jpg');
img2 = imread('../data/flower.jpg');

tic;
%% Your code here
[x,y,ch] = size(img2);
for i =1:ch
    hist1= imhist(img2(:,:,i));
    cdf = cumsum(hist1)/sum(hist1);
    final(:,:,i) = uint8(255*cdf(img2(:,:,i)+1));
end

bird_mask = mask(img1, 16, [340,500]);
kernel = ones(10) / 10 ^ 2;
bird_mask = imfilter(bird_mask,kernel);
bird_mask = im2bw(bird_mask,0.5);
figure(1);
subplot(1,3,1);
imshow(bird_mask);
title('Mask');
subplot(1,3,2);
imshow(img1.*(uint8(bird_mask)));
title('Foreground');
subplot(1,3,3);
imshow(img1.*(uint8(~bird_mask)));
title('Background');
toc;
%%
tic;
[bird_blur,bird_contour, kern12, kern22, kern32, kern42, kern52] = mySpatiallyVaryingKernel(bird_mask,img1,40);
figure(2);
imshow(bird_contour);
title('Contour for bird');
figure(3);
color(bird_blur);
title('Blurred Background for Bird');
toc;
%%
tic;
flower_mask = mask(final(:,:,1),3 , [156,237]);
kernel = ones(10) / 10 ^ 2;
flower_mask = imfilter(flower_mask,kernel);
flower_mask = im2bw(flower_mask,0.5);
figure(4);
subplot(1,3,1);
imshow(flower_mask);
title('Mask');
subplot(1,3,2);
imshow(img2.*(uint8(flower_mask)));
title('Foreground');
subplot(1,3,3);
imshow(img2.*(uint8(~flower_mask)));
title('Background');
toc;
%%

[flower_blur,flower_contour, kern1, kern2, kern3, kern4, kern5] = mySpatiallyVaryingKernel(flower_mask,img2,20);
figure(5);
imshow(flower_contour);
title('Contour for Flower');
figure(6);
color(flower_blur);
title('Blurred Background for flower');
%%
figure(7);
colormap(gray(256));
subplot(2,3,6);
imshow([]);
subplot(2,3,2);
imagesc(kern2);
title('0.4dthresh');
subplot(2,3,3);
imagesc(kern3);
title('0.6dthresh');
subplot(2,3,4);
imagesc(kern4);
title('0.8dthresh');
subplot(2,3,5);
imagesc(kern5);
title('dthresh');
subplot(2,3,1);
imagesc(kern1);
title('0.2dthresh');

%%
function imgColor = color(img)
    myNumOfColors = 200;
    myColorScale = [[0:1/(myNumOfColors-1):1]', [0:1/(myNumOfColors-1):1]', [0:1/(myNumOfColors-1):1]'];
    imagesc(img);
    colormap (myColorScale);
    colormap jet;
    daspect ([1 1 1]);
    colorbar
end

