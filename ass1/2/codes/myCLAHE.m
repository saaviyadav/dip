function GIm = myCLAHE(GIm, window, thresh)
    [x,y,ch] = size(GIm);
    for i = 1:ch
        GIm(:,:,i) = clahe(GIm(:,:,i), window, thresh);
    end
end

function final = clahe(GIm, window, thresh)
    w = floor(window/2);
    for i = 1:size(GIm,1)
        for j = 1:size(GIm,2)
           x_range = max(i-w,1):min(size(GIm,1),i+w);
           y_range = max(j-w,1):min(size(GIm,2),j+w);
           if (i <= w)
               centre_x =  i;
           else centre_x = w+1;
           end
           if (j <= w)
               centre_y =  j;
           else centre_y = w+1;
           end
           numofpixels = length(x_range)*length(y_range);
           imp1 = GIm(x_range, y_range);
           hist = (imhist(imp1)/numofpixels);
           while(true)
               count = 0;
               for k = 1:length(hist)
                   if hist(k)>thresh
                       count = count+(hist(k)-thresh);
                       hist(k) = thresh - 0.5/numofpixels;
                   end
               end
               hist1 = hist;
               if  max(hist1)-thresh < 0.001
                   break;
               end
               hist1 = hist1+count/length(hist);
           end
           cdf = cumsum(hist1);
           cdf = round((length(hist1)-1)*cdf);
           final(i,j) = cdf(imp1(centre_x,centre_y)+1);
        end
        if mod(i,10) == 0
            display(strcat('Finished : ',num2str(i/size(GIm,1)*100)));
        end
    end
end
