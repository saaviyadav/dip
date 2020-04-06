
function [ im2 ] = myPCADenoising2( im1,patch, sigma )
K = 200;
[m,n] = size(im1);

PNew = zeros(patch^2,(size(im1,1)-patch+1)*(size(im1,2)-patch+1));
im2 = zeros(size(im1));
im2label = zeros(size(im1));
for i = 1:n-patch+1
    for j = 1:m-patch+1
        X = im1(i:i+patch-1,j:j+patch-1);
        Pneb = im2col(im1(max(1,i-12):min(i+18,m), max(1,j-12):min(j+18,n)),[7,7]);
        ID = knnsearch(Pneb',X(:)','k',K);
        Q = Pneb(:,ID(:)');
        [V,~] = eig(Q*Q');
        alphai = V' * X(:);
        alpha = V' * Q;
        alphaBarSquare = max(0,(sum(alpha.^2,2) / K) - sigma^2);
        alphaPiDenoised = (alphai ./ (1 + (sigma^2) ./ alphaBarSquare)); 
        PiNew = V * alphaPiDenoised;
        PNew(:,i) = PiNew;
        im2(i:i+patch-1,j:j+patch-1) = im2(i:i+patch-1,j:j+patch-1) + reshape(PiNew, 7, 7); 
        im2label(i:i+patch-1,j:j+patch-1) = im2label(i:i+patch-1,j:j+patch-1) + 1;
    end
end

im2 = im2 ./ im2label;
end
