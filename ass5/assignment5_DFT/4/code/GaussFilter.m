function [ new_img, filt ] = GaussFilter(  img, D )
[l w] = size(img);

H = zeros(size(img));
for u=1:l
   for v=1:w
       if((u-128)^2 + (v-128)^2 <= D^2)
           H(u,v) = exp(-((u-128)^2 + (v-128)^2)/(2*D^2));
       end
   end
end
new_img = ifft2(ifftshift(img.*H));    
filt = log(abs(H)+1);
end