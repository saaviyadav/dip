function [corner,eigen1,eigen2, derivative_x,derivative_y] = myHarrisCornerDetector(img,s1,s2,k)
    img = mat2gray(img);
    high = max(max(img));
    low = min(min(img));
    img = (img - low)/(high-low);
    gauss = fspecial('gaussian', 5, s1);
    [deriv_x, deriv_y] = gradient(gauss);
    derivative_x = conv2(img,deriv_x,'same');
    derivative_y = conv2(img,deriv_y,'same');
    ixx = derivative_x.*derivative_x;
    ixy = derivative_x.*derivative_y;
    iyy = derivative_y.*derivative_y;
    gauss_sum = fspecial('gaussian', 5, s2);
    sx2 = conv2(ixx,gauss_sum,'same');
    sy2 = conv2(iyy,gauss_sum,'same');
    sxy = conv2(ixy,gauss_sum,'same');
    for i = 1:size(img,1)
        for j = 1:size(img,2)
            h =  [sx2(i,j) sxy(i,j);sxy(i,j) sy2(i,j)];
            trace_h = trace(h);
            det_h = det(h);
            corner(i,j) =  det_h - k*((trace_h)^2);
            eigen = eig(h);
            eigen1(i,j) = eigen(1,:);
            eigen2(i,j) = eigen(2,:);
        end
    end
end