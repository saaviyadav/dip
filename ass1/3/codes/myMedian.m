function answer = myMedian(GIm)
    [x,y,ch] = size(GIm);
    for i = 1:ch
        answer(:,:,i) = med(GIm(:,:,i));
    end
end

function final = med(GIm)
    in_value = GIm(:);
    a = double(median(in_value));
    hist = imhist(GIm);
    hist1 = hist(1:a);
    hist2 = hist(a+1:length(hist));
    cdf1 = cumsum(hist1)/sum(hist1);
    cdf2 = cumsum(hist2)/sum(hist2);
    
    for i = 1:size(GIm,1)
        for j = 1:size(GIm,2)
            if GIm(i,j) < a
                final(i,j) =  (a)*cdf1(GIm(i,j)+1);
            else 
                final(i,j) =  a+(255-a-1)*cdf2(GIm(i,j)-a+1);
            end
        end
    end
    final = uint8(final);
end
