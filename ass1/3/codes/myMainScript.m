%% MyMainScript

tic;
%% Your code here
img = imread('../data/example.png');
answer = myMedian(img);
hist1= imhist(img);
cdf = cumsum(hist1)/sum(hist1);
final = uint8(255*cdf(img(:,:)+1));
subplot(1,3,1);
imshow(img);
title('Orignal');
subplot(1,3,2);
imshow(final);
title('Simple Histogram Eq');
subplot(1,3,3);
imshow(answer);
title('Modified Histogram Eq');
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