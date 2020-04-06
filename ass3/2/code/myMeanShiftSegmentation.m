function [answer,i] = myMeanShiftSegmentation(img,s1,s2)
    k = 20;
    window = 25;
    w = floor(window/2);
    step_size = 1;
    img = double(img);  
    answer = double(img);
    x_index = (1:window)';
    y_index = (1:window);
    dist_x = double(exp((x_index - w+1).^2));
    dist_y = double(exp((y_index - w+1).^2));
    euc_dist = log(dist_x*dist_y);
    prev_answer = img;
    for i= 1:25
        r = prev_answer(:,:,1);
        g = prev_answer(:,:,2);
        b = prev_answer(:,:,3);
        display(num2str(i))
        for x = 1:size(img,1)
            start_x = max(1,x-w);
            end_x = min(size(img,1),x+w);
            for y = 1:size(img,2)
                start_y = max(1,y-w);
                end_y = min(size(img,2),y+w);
                left_x = w + 1 - (x - start_x);
                right_x = w + 1 + (end_x - x);
                top_y= w + 1 - (y - start_y);
                bottom_y = w + 1 + (end_y - y);
                spatial_diff = euc_dist(left_x:right_x,top_y:bottom_y);
                spatial_kernel = repmat(exp(-spatial_diff/(s2*s2)),1,1,3);
                intensity_win = prev_answer(start_x:end_x,start_y:end_y,:);
                intensity_diff = intensity_win - repmat(prev_answer(x,y,:), size(intensity_win,1), size(intensity_win,2));
                intensity_kernel = exp(-(intensity_diff.^2)/(s1*s1));
                
                num = sum(sum(double(intensity_win).*intensity_kernel.*spatial_kernel));
                den = sum(sum(intensity_kernel.*spatial_kernel));
                Inew = prev_answer(x,y,:) + step_size * (num./den - prev_answer(x,y,:));
                answer(x,y,:) = Inew;
            end
        end
        %(sum(sum(sum(prev_answer - answer).^2))/(size(img,1)*(size(img,2))))
        if (sum(sum(sum(prev_answer - answer).^2))/(size(img,1)*(size(img,2)))) < 20
            break;
        end
        prev_answer = answer;
    end   
end
