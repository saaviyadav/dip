function [img_iff,log_ans] = idealLow(img,D)
[m,n] = size(img);
H = zeros(size(img));
for i = 1:m
    for j= 1:n
        if((i-m/2)^2+(j-n/2)^2 <=D^2)
            H(i,j) = 1;
        end
    end
end
img_iff = ifft2(ifftshift(img.*H));
log_ans = log(abs(H)+1);
end