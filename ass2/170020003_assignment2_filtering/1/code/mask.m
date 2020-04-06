function visited = mask(im, thresh, start)
    visited = zeros(size(im,1),size(im,2));
    queue =  [start];
    visited(start) = 1;
    ctr = 1;
    while(size(queue,1) ~= 0)
        top = queue(1,:);
        queue = queue(2:size(queue,1),:);
        if distance(im(top(1,1),top(1,2),:),im(top(1,1)+1,top(1,2),:), thresh) && ~visited(top(1,1)+1,top(1,2))
            queue = [queue;[top(1,1)+1,top(1,2)]];
            visited(top(1,1)+1,top(1,2)) = 1;
        end
        if distance(im(top(1,1),top(1,2),:),im(top(1,1),top(1,2)+1,:), thresh) && ~visited(top(1,1),top(1,2)+1)
            queue = [queue;[top(1,1),top(1,2)+1]];
            visited(top(1,1),top(1,2)+1) = 1;
        end 
        if distance(im(top(1,1),top(1,2),:),im(top(1,1)-1,top(1,2),:), thresh) && ~visited(top(1,1)-1,top(1,2))
            queue = [queue;[top(1,1)-1,top(1,2)]];
            visited(top(1,1)-1,top(1,2)) = 1;
        end
        if distance(im(top(1,1),top(1,2),:),im(top(1,1),top(1,2)-1,:), thresh) && ~visited(top(1,1),top(1,2)-1)
            queue = [queue;[top(1,1),top(1,2)-1]];
            visited(top(1,1),top(1,2)-1) = 1;
        end

        if distance(im(top(1,1),top(1,2),:),im(top(1,1)+1,top(1,2)+1,:), thresh) && ~visited(top(1,1)+1,top(1,2)+1)
            queue = [queue;[top(1,1)+1,top(1,2)+1]];
            visited(top(1,1)+1,top(1,2)+1) = 1;
        end
        if distance(im(top(1,1),top(1,2),:),im(top(1,1)-1,top(1,2)+1,:), thresh) && ~visited(top(1,1)-1,top(1,2)+1)
            queue = [queue;[top(1,1)-1,top(1,2)+1]];
            visited(top(1,1)-1,top(1,2)+1) = 1;
        end 
        if distance(im(top(1,1),top(1,2),:),im(top(1,1)-1,top(1,2)-1,:), thresh) && ~visited(top(1,1)-1,top(1,2)-1)
            queue = [queue;[top(1,1)-1,top(1,2)-1]];
            visited(top(1,1)-1,top(1,2)-1) = 1;
        end
        if distance(im(top(1,1),top(1,2),:),im(top(1,1)+1,top(1,2)-1,:), thresh) && ~visited(top(1,1)+1,top(1,2)-1)
            queue = [queue;[top(1,1)+1,top(1,2)-1]];
            visited(top(1,1)+1,top(1,2)-1) = 1;
        end
        ctr = ctr + 1;
%         if mod(ctr,1000) == 0
%             imshow(im .* uint8(repmat(visited,1,1,3)));
%         end
    end
end

function answer = distance(i1,i2,thresh)
    dist = sum(double((i1-i2).^2))^0.5;
    if dist>thresh
        answer = false;
    else
        answer = true;
    end
end
