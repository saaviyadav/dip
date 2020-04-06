%% MyMainScript
clc;
clear;
tic;
%% Your code here
k = [2, 10, 20, 50, 75, 100, 125, 150, 175];
faces = "../../../att_faces";
train = [];
X = 0;
for i = 1:32
    for j = 1:6
        img_loc = faces+"/"+"s"+num2str(i)+"/"+num2str(j)+".pgm";
        img = double(imread(img_loc));
        img_gal = reshape(img,[92*112, 1]);
        train = [train img_gal];
        X = X+img_gal;
    end
end
X = X/size(train,2);
train = double(train - X);
img_loc = faces+"/s6/1.pgm";
img = double(imread(img_loc));
test = reshape(img,[92*112, 1]);

%%
tic;
%using svd
[U,S,V] = svd(train,0);
RMS = sqrt(sum(U.^2,1)); 
RMS = repmat(RMS,size(U,1),1);
U = U ./ RMS;
figure(1);
for i=1:9
   vk = U(:,1:k(i));
   b = vk'*(test - X);
   x = X + vk*b;
   x = uint8(reshape(x,[112 92]));
   subplot(3,3,i);
   imshow(x);
   title(strcat('k = ',int2str(k(i))));
end
toc;
figure(2);
for i = 1:25
    eigen = reshape(U(:,i),[112,92]);
    subplot(5,5,i);
    imshow(mat2gray(eigen));
end
