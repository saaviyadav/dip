function match = myHm(img, imgMatch)
[x,y,ch] = size(img);
match = img;
    for j = 1:ch
        imgM = imgMatch(:,:,j);
        img1 = img(:,:,j);
        [histmatch, ~] = imhist(imgM);
        [histimg,~] = imhist(img1);
        cdfMatch = cumsum(histmatch)/(x*y);
        cdf = cumsum(histimg)/(x*y);
        for i = 1:256
            [~, den] = min(abs(cdfMatch - cdf(i)));
            cdf_new(i) = den;
        end
        match(:,:,j) = cdf_new(double(img1)+1);
    end
end