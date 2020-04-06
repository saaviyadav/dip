%% MyMainScript


%% Your code here
% Svd
k = [1, 2, 3, 5, 10, 15, 20, 30, 50, 75, 100, 150, 170];
faces = "../../../att_faces";
train = [];
trainlabel = [];
test = [];
testlabel = [];
X = 0;
for i = 1:32
    for j = 1:6
        img_loc = faces+"/"+"s"+num2str(i)+"/"+num2str(j)+".pgm";
        img = double(imread(img_loc));
        img_gal = reshape(img,[92*112, 1]);
        train = [train img_gal];
        X = X+img_gal;
        trainlabel = [trainlabel i];
    end
end
X = X/size(train,2);
train = double(train - X);
for i = 1:32
    for j = 7:10
        img_loc = faces+"/"+"s"+num2str(i)+"/"+num2str(j)+".pgm";        
        img = double(imread(img_loc));
        img_gal = reshape(img,[92*112, 1]);
        test = [test img_gal];
        testlabel = [testlabel i];
    end
end
%%
tic;
%using svd
[U,S,V] = svd(train,0);
RMS = sqrt(sum(U.^2,1)); 
RMS = repmat(RMS,size(U,1),1);
U = U ./ RMS;
rates = [];
for i=1:13
   vk = U(:,1:k(i));
   a = vk'*train;
   count = 0;
   for j = 1:size(test,2)
       b = vk'*(test(:,j) - X);
       [val,index] = min(sum((a - repmat(b,1,size(b,2))).^2));
        if(trainlabel(index) == testlabel(j))
            count = count + 1;
        end
   end
   rates = [rates,(count/size(test,2))*100];
end
toc;
figure(1);
plot(k,rates,'-ko','MarkerSize',5,'Color','b','MarkerFaceColor','g');
title('Squared Error(ORL Database), Function : svd');
xlabel('k-features');
ylabel('recognition-rates(percent)');
%%
tic;
%eig
[V2,D2] = eig(train'*train);
U2 = train*V2;
RMS = sqrt(sum(U2.^2,1)); 
RMS = repmat(RMS,size(U2,1),1);
U2 = U2./ RMS;
rates2 = [];
for i=1:13
   vk2 = U2(:,1:k(i));
   a2 = vk2'*train;
   count = 0;
   for j = 1:size(test,2)
       b2 = vk2'*(test(:,j) - X);
       [val2,index2] = min(sum((a2 - repmat(b2,1,size(b2,2))).^2));
        if(trainlabel(index2) == testlabel(j))
            count = count + 1;
        end
   end
   rates2 = [rates2,(count/size(test,2))*100];
end
toc;
figure(2);
plot(k,rates,'-ko','MarkerSize',5,'Color','b','MarkerFaceColor','g');
title('Squared Error(ORL Database), Function : eig');
xlabel('k-features');
ylabel('recognition-rates(percent)');
toc;
%%
tic;
yaleFaceDatabase = "../../../CroppedYale";
k = [1, 2, 3, 5, 10, 15, 20, 30, 50, 60, 65, 75, 100, 200, 300, 500, 1000];
myFolder = dir(yaleFaceDatabase);
trainY = zeros(192*168,38*40);
trainlabelY = zeros(1,38*40);
testY = zeros(192*168,38*24);
testlabelY = zeros(1,38*24);
X = 0;
for i = 3:length(myFolder)
    myFile = dir(strcat(yaleFaceDatabase,'/',myFolder(i).name));
    for j = 3:42
        img = double(imread(yaleFaceDatabase+'/'+myFolder(i).name+'/'+myFile(j).name));
        img_gal = reshape(img,[192*168, 1]);
        trainY(:,(i-3)*40+j-2) = img_gal;
        X = X + img_gal;
        trainlabelY(:,(i-3)*40+j-2) = i-2;
    end
end
X = X/size(trainY,2);
trainY = trainY - X;
for i = 3:length(myFolder)
    myFile = dir(strcat(yaleFaceDatabase,'/',myFolder(i).name));
    for j = 43:length(myFile)
        img = double(imread(strcat(yaleFaceDatabase,'/',myFolder(i).name,'/',myFile(j).name)));
        img_gal = reshape(img,[192*168, 1]);
        testY(:,(i-3)*24+j-42) = img_gal;
        testlabelY(:,(i-3)*24+j-42) = i-2;
    end
end
toc;
%%
%part a
tic;
[UY,SY,VY] = svd(trainY,0);
RMS = sqrt(sum(UY.^2,1)); 
RMS = repmat(RMS,size(UY,1),1);
UY = UY ./ RMS;

ratesY = zeros(17,1);
%%
for i=1:17
   vkY = UY(:,1:k(i));
   aY = vkY'*trainY;
   count = 0;
   for j = 1:size(testY,2)
       bY = vkY'*(testY(:,j) - X);
       [val,index] = min(sum((aY - repmat(bY,1,size(bY,2))).^2));
        if(trainlabelY(index) == testlabelY(j))
            count = count + 1;
        end
   end
   ratesY(i) = (count/size(testY,2))*100;
end
toc;
figure(3);
plot(k,ratesY,'-ko','MarkerSize',5,'Color','b','MarkerFaceColor','g');
title('Squared Error(Yale Database)');
xlabel('k-features');
ylabel('recognition-rates(percent)');
%%
tic;
for i=1:17
   vkY = UY(:,3:3+k(i));
   aY = vkY'*trainY;
   count = 0;
   for j = 1:size(testY,2)
       bY = vkY'*(testY(:,j) - X);
       [val,index] = min(sum((aY - repmat(bY,1,size(bY,2))).^2));
        if(trainlabelY(index) == testlabelY(j))
            count = count + 1;
        end
   end
   ratesY(i) = (count/size(testY,2))*100;
end
toc;
figure(4);
plot(k,ratesY,'-ko','MarkerSize',5,'Color','b','MarkerFaceColor','g');
title('Squared Error(Yale Database) removing first 3 eigen values');
xlabel('k-features');
ylabel('recognition-rates(percent)');
toc;