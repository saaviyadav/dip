function final = myHE(img)
    [x,y,ch] = size(img);
    for i =1:ch
        hist1= imhist(img(:,:,i));
        cdf = cumsum(hist1)/sum(hist1);
        final(:,:,i) = uint8(255*cdf(img(:,:,i)+1));
    end
end
