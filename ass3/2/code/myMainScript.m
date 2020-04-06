%% MyMainScript
clear;
import mlreportgen.report.*
R = Report('Question2','pdf');
open(R);
img1 = imread('../data/flower.png');
tic;
%% Your code here
[answer,iter] = myMeanShiftSegmentation(img1, 30, 15);
figure(1);
subplot(1,2,1);
imshow(img1);
title('Original Image');
subplot(1,2,2);
imshow(uint8(answer));
title('Segmented Image');
toc;
%%
add(R, Figure);
add(R, 'Kernel Bandwidth for Color Feature = 30');
add(R, 'Kernel Bandwidth for Spatial Feature = 12');
%%
add(R, strcat('Iterations = ',num2str(iter)));
close(R);