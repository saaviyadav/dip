function [blurred,contour,kern1, kern2, kern3, kern4, kern5] = mySpatiallyVaryingKernel(mask, img, dp)
    padded = zeros(2*dp+size(img,1),2*dp+size(img,2),size(img,3));
    padded(dp+1:size(padded,1) -dp, dp+1:size(padded,2) -dp,:) = img;
    paddedMask = zeros(2*dp+size(img,1),2*dp+size(img,2));
    paddedMask(dp+1:size(paddedMask,1) -dp, dp+1:size(paddedMask,2) -dp) = mask;
    [bound, indices] = boundary(mask);
    contour = img;
    contour(:,:,:) = 255;
    blurred = img;
    kern1 = disc(0.2*dp)/(sum(sum(disc(0.2*dp))));
    kern2 = disc(0.4*dp)/(sum(sum(disc(0.4*dp))));
    kern3 = disc(0.6*dp)/(sum(sum(disc(0.6*dp))));
    kern4 = disc(0.8*dp)/(sum(sum(disc(0.8*dp))));
    kern5 = disc(1*dp)/(sum(sum(disc(1*dp))));
    for i = 1:size(img,1)
        if (mod(i,10) == 0) 
            display(strcat('Completed', num2str(i/size(img,1))));
        end
        for j = 1:size(img,2)
            if mask(i, j) == 0
                dist_x = abs(i - indices(:,1));
                dist_y = abs(j - indices(:,2));
                d = floor(min(double(dist_x.^2 + dist_y.^2).^0.5));
                d = min([dp,d]);
                if mod(d,4) == 0
                    contour(i,j,:) = contour(i,j,:)/(d/4);
                end
                kernel = disc(d);
                window = padded(i:i+2*d, j:j+2*d,:);
                count = sum(sum(kernel));
                kernel = kernel ./ count;
                blurred(i,j,1) = sum(sum(kernel.*window(:,:,1)));
                blurred(i,j,2) = sum(sum(kernel.*window(:,:,2)));
                blurred(i,j,3) = sum(sum(kernel.*window(:,:,3)));
            end
        end
    end
end

function [bound, indices] = boundary(mask)
    bound = 0 .* mask;
    indices = [];
    for i = 1:size(mask,1)
        for j = 1:size(mask,2)
            if(mask(i,j) == 1 && ~(mask(i+1,j) && mask(i,j+1) && mask(i-1,j) && mask(i,j-1)))
                bound(i,j) = 1;
                indices = [indices; i,j];
            end
        end
    end
end

function [kernel] = disc(d)
    kernel = zeros(2*d+1,2*d+1);
    for i = -d:d
        for j = -d:d
            if i^2+j^2<d^2
                kernel(i+d+1,j+d+1) = 1;
            end
        end
    end
end