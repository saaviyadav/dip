%% MyMainScript
clear; clc;
tic;
%% Your code here
img1 = imread('../data/barbara.png');
img3 = imread('../data/canyon.png');
img6 = imread('../data/chestXray.png');
img5 = imread('../data/church.png');
img4 = imread('../data/retina.png');
img8 = imread('../data/retinaMask.png');
img2 = imread('../data/TEM.png');
img7 = imread('../data/statue.png');

%Q 2a
img7_mask = myForegroundMask(img7);
figure(1);
colormap(gray(256));
subplot(1,3,1); 
imshow(img7);
title('Original Image'); colorbar
subplot(1,3,2); 
imshow(img7_mask.*255);
title('mask'); colorbar
subplot(1,3,3); 
imshow(img7_mask.*img7);
title('unmask'); colorbar
%Q 2b

answer = myLinearContrastStretching(img1);
figure(2);
colormap(gray(256));
subplot(1,2,1); 
imshow(img1);
title('Original Image'); colorbar
subplot(1,2,2); 
imshow(answer);
title('Linear Contrast Streching'); colorbar

answer = myLinearContrastStretching(img2);
figure(3);
colormap(gray(256));
subplot(1,2,1); 
imshow(img2);
title('Original Image'); colorbar
subplot(1,2,2); 
imshow(answer);
title('Linear Contrast Streching'); colorbar

answer = myLinearContrastStretching(img3);
figure(4);
subplot(1,2,1);
color(img3);
title('Original Image'); 
subplot(1,2,2); 
color(answer);
title('Linear Contrast Streching');

answer = myLinearContrastStretching(img5);
figure(5);
subplot(1,2,1);
color(img5);
title('Original Image'); 
subplot(1,2,2); 
color(answer);
title('Linear Contrast Streching');

answer = myLinearContrastStretching(img6);
figure(6);
colormap(gray(256));
subplot(1,2,1); 
imshow(img6);
title('Original Image'); colorbar
subplot(1,2,2); 
imshow(answer);
title('Linear Contrast Streching'); colorbar

answer = myLinearContrastStretching(img7.*img7_mask);
figure(7);
colormap(gray(256));
subplot(1,2,1); 
imshow(img7);
title('Original Image'); colorbar
subplot(1,2,2); 
imshow(answer);
title('Linear Contrast Streching'); colorbar

%Q 2c
answer = myHE(img1);
figure(8);
colormap(gray(256));
subplot(1,2,1); 
imshow(img1);
title('Original Image'); colorbar
subplot(1,2,2); 
imshow(answer);
title('HE'); colorbar

answer = myHE(img2);
figure(9);
colormap(gray(256));
subplot(1,2,1); 
imshow(img2);
title('Original Image'); colorbar
subplot(1,2,2); 
imshow(answer);
title('HE'); colorbar

answer = myHE(img3);
figure(10);
subplot(1,2,1);
color(img3);
title('Original Image'); 
subplot(1,2,2); 
color(answer);
title('HE');

answer = myHE(img5);
figure(11);
subplot(1,2,1); 
color(img5);
title('Original Image'); colorbar
subplot(1,2,2); 
color(answer);
title('HE'); colorbar

answer = myHE(img6);
figure(12);
colormap(gray(256));
subplot(1,2,1); 
imshow(img6);
title('Original Image'); colorbar
subplot(1,2,2); 
imshow(answer);
title('HE'); colorbar

answer = myHE(img7);
figure(13);
colormap(gray(256));
subplot(1,2,1); 
imshow(img7);
title('Original Image'); colorbar
subplot(1,2,2); 
imshow(answer);
title('HE'); colorbar

%Q 2d

img4ref = imread('../data/retinaRef.png');
figure(14);
answer = myHM(img4,img4ref);
subplot(1,3,1);
color(img4);
title('Original Image');
subplot(1,3,2);
color(answer);
title('Histogram Matching');
subplot(1,3,3);
color(myHE(img4));
title('Histogram Equalization');

 
% %Q 2e
answer = myCLAHE(img1, 151, 0.04);
figure(15);
colormap(gray(256));
subplot(1,2,1); 
imshow(img1);
title('Original Image'); colorbar
subplot(1,2,2); 
imshow(answer);
title('CLAHE (window=151, threshold=0.04)'); colorbar

answer = myCLAHE(img1, 400, 0.04);
figure(16);
colormap(gray(256));
subplot(1,2,1); 
imshow(img1);
title('Original Image'); colorbar
subplot(1,2,2); 
imshow(answer);
title('CLAHE (window=400, threshold=0.04)'); colorbar

answer = myCLAHE(img1, 21, 0.04);
figure(17);
colormap(gray(256));
subplot(1,2,1); 
imshow(img1);
title('Original Image'); colorbar
subplot(1,2,2); 
imshow(answer);
title('CLAHE (window=21, threshold=0.04)'); colorbar

answer = myCLAHE(img1, 151, 0.02);
figure(18);
colormap(gray(256));
subplot(1,2,1); 
imshow(img1);
title('Original Image'); colorbar
subplot(1,2,2); 
imshow(answer);
title('CLAHE (window=151, threshold=0.02)'); colorbar

answer = myCLAHE(img2, 201, 0.04);
figure(19);
colormap(gray(256));
subplot(1,2,1); 
imshow(img2);
title('Original Image'); colorbar
subplot(1,2,2); 
imshow(answer);
title('CLAHE (window=201, threshold=0.04)'); colorbar

answer = myCLAHE(img3, 301, 0.04);
figure(20);
subplot(1,2,1); 
color(img3);
title('Original Image'); 
subplot(1,2,2); 
color(answer);
title('CLAHE (window=301, threshold=0.04)'); colorbar

answer = myCLAHE(img6, 151, 0.04);
figure(21);
colormap(gray(256));
subplot(1,2,1); 
imshow(img6);
title('Original Image'); colorbar
subplot(1,2,2); 
imshow(answer);
title('CLAHE (window=151, threshold=0.04)'); colorbar

toc;

function imgColor = color(img)
    myNumOfColors = 200;
    myColorScale = [[0:1/(myNumOfColors-1):1]', [0:1/(myNumOfColors-1):1]', [0:1/(myNumOfColors-1):1]'];
    imagesc(img);
    colormap (myColorScale);
    colormap jet;
    daspect ([1 1 1]);
    colorbar
end
