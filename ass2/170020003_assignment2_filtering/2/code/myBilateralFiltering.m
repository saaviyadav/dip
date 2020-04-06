function [corrupted,filtered,mask] = myBilateralFiltering(img, si1, si2)
    window = 7;
    w = floor(window/2);
    high = max(max(img));
    low = min(min(img));
    coeff = double((high - low)*0.05);
    corrupted = uint8(double(img) + coeff*randn(size(img,1),size(img,2)));
    padded = zeros(size(img,1)+2*w, size(img,2)+2*w);
    padded(w+1:size(padded,1)-w,w+1:size(padded,1)-w) = corrupted;
    x_index = (1:window)';
    y_index = (1:window);
    dist_x = double(exp((x_index - w+1).^2));
    dist_y = double(exp((y_index - w+1).^2));
    euc_dist = log(dist_x*dist_y);
    mask = img;
    for i = 1:size(img,1)
        for j = 1:size(img,2)
            [filtered(i,j), mask(i,j)] = denoised(padded(i:i+window-1, j:j+window-1),si1,si2, euc_dist);
        end
    end
end
function [fil,int_mask] = denoised(img, si1, si2, euc_dist)
    window = size(img,1);
    w = floor(window/2);
    int_data = double(img(:,:) - img(w+1, w+1)).^2;
    wi = sum(sum(exp(-(euc_dist)/(2*si1*si1) - (int_data)/(2*si2*si2))));
    int_mask = sum(sum((int_data)/(2*si2*si2)));
    fil = uint8(sum(sum(img(:,:).*exp(-(euc_dist)/(2*si1*si1) - (int_data)/(2*si2*si2))))/wi);
end