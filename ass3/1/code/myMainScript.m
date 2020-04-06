import mlreportgen.report.*
R = Report('Question1','pdf');
open(R);

%% % MyMainScript
img1 = load('../data/boat.mat');
img1 = uint8(img1.imageOrig);

tic;
%% Your code here
[corner,eigen1,eigen2, derivative_x,derivative_y] = myHarrisCornerDetector(img1,1,1,0.01);

toc;
%%
figure(1);
colormap(gray(256));
subplot(1,2,1);
imagesc((derivative_x));
title('X derivative');
subplot(1,2,2);
imagesc((derivative_y));
title('Y derivative');
add(R, Figure);

figure(2);
colormap(gray(256));
subplot(1,2,1);
imagesc((eigen1));colorbar;
title('First Eigen Value'); 
subplot(1,2,2);
imagesc((eigen2));colorbar;
title('Second Eigen Value'); 
add(R, Figure);

figure(3);
colormap(gray(256));
imagesc((corner));colorbar;
title('Cornerness'); 
add(R, Figure);

add(R,'Sigma1 = 1, Sigma2 = 1, k = 0.01');
close(R);
