%% MyMainScript
%% ORL Face Dataset
%% ORL Face Dataset
clc; clear;
tic;
attFaceDatabase = '../../../att_faces';
trainingSet = [];  
validationSet = [];
testingSet1 = [];
testingSet2 = [];

for i = 1:32
    for j = 1:5
        image = double(imread(strcat('../../../att_faces/s', int2str(i), '/', int2str(j), '.pgm')));
        trainingSet = horzcat(trainingSet,image(:)); 
    end
end

for i = 1:32
    for j = 6:6
        image = double(imread(strcat('../../../att_faces/s', int2str(i), '/', int2str(j), '.pgm')));
        validationSet = horzcat(validationSet,image(:));
    end
end

for i = 1:32
    for j = 7:10
        image = double(imread(strcat('../../../att_faces/s', int2str(i), '/', int2str(j), '.pgm')));
        testingSet1 = horzcat(testingSet1,image(:));
    end
end

for i = 33:40
    for j = 7:10
        image = double(imread(strcat('../../../att_faces/s', int2str(i), '/', int2str(j), '.pgm')));
        testingSet2 = horzcat(testingSet2,image(:)); 
    end
end


Xbar = mean(trainingSet,2);
X = trainingSet - repmat(Xbar,1,size(trainingSet,2));
Y = validationSet - repmat(Xbar,1,size(validationSet,2));
L = X' * X;

[W,T] = eig(L);
V = X * W;
V = normc(V);
k = 30;

Vk = V(:,size(V,2)-k+1:size(V,2));
alphaTrain = Vk' * X;
alphaVerif = Vk' * Y;
alphaVerif = repelem(alphaVerif,1,5);
distances = sqrt(sum((alphaTrain - alphaVerif).^2,1));

thresholds = 0.7 * mean(reshape(distances, 5, 32), 1) + 0.3 * min(reshape(distances, 5, 32), [], 1);

% distances of testing set 1 : 
alpha1 = Vk' * (testingSet1 - repmat(Xbar,1,size(testingSet1,2)));
minDist1 = [];
index1 = [];
for alphai = alpha1
    alphai = repelem(alphai,1,size(alphaTrain,2));
    dist = sqrt(sum((alphaTrain - alphai).^2,1));
    [val,index] = min(dist);
    minDist1 = [minDist1,val];
    index1 = [index1,floor((index+4)/5)];
end

% distances of testing set 2 : 
alpha2 = Vk' * (testingSet2 - repmat(Xbar,1,size(testingSet2,2)));
minDist2 = [];
index2 = [];
for alphai = alpha2
    alphai = repelem(alphai,1,size(alphaTrain,2));
    dist = sqrt(sum((alphaTrain - alphai).^2,1));
    [val,index] = min(dist);
    minDist2 = [minDist2,val];
    index2 = [index2,floor((index+4)/5)];
end

falseNegative = 0;
for i = 1:size(minDist1,2)
    if(thresholds(index1(i)) < minDist1(i))
        falseNegative = falseNegative + 1;
    end
end

falsePositive = 0;
for i = 1:size(minDist2,2)
    if(thresholds(index2(i)) > minDist2(i))
        falsePositive = falsePositive + 1;
    end
end

toc;
