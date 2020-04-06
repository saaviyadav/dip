function [res] = myPCADenoising(img,patch,var)
    [m,n] = size(img);
    N = (m-patch+1)*(n-patch+1);
    P = zeros(patch*patch,N);
    for i = 1:m-patch+1
        for j = 1:n-patch+1
            P(:,(i-1)*(n-patch+1)+j) = reshape(img(i:i+patch-1,j:j+patch-1),[],1);
        end
    end
    [U,D] = eig(P*P');
    eig_coeff = U'*P;
    a_mean = max(0,diag(eig_coeff*eig_coeff')/N-var);
    Den = (1+var./a_mean).^(-1);
    alphaDen = diag(Den)*eig_coeff;
    img2 = zeros(m,n);
    img_label = zeros(m,n);
    for i = 1:m-patch+1
        for j = 1:n-patch+1
            img2(i:i+patch-1,j:j+patch-1) = img2(i:i+patch-1,j:j+patch-1) + reshape(P(:,(i-1)*(n-patch+1)+j),[],patch);
            img_label(i:i+patch-1,j:j+patch-1) = img_label(i:i+patch-1,j:j+patch-1) + 1;
        end
    end
    res = img2./img_label;
end