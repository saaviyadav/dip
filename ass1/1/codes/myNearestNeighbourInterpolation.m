function [ Y ] = myNearestNeighbourInterpolation(I)
    [h, w] = size(I);
    H = (3 * h);
    W = (2 * w);
    Y = zeros(H,W,'uint8');
    hs = (h/H);
    ws = (w/W);
    for i=1:H
      y = (hs * i) + (0.5 * (1 - 1/3));
        for j=1:W
          x = (ws * j) + (0.5 * (1 - 1/2));
      %   Any values out of acceptable range
          x(x < 1) = 1;
          x(x > h - 0.001) = h - 0.001;
          x1 = floor(x);
          x2 = x1 + 1;
          y(y < 1) = 1;
          y(y > w - 0.001) = w - 0.001;
          y1 = floor(y);
          y2 = y1 + 1;
          
          if (x-x1 < x2-x)
              if (y-y1 < y2-y) Y(i,j) = I(y1,x1);
              else Y(i,j) = I(y2,x1); end
          else
              if (y-y1 < y2-y) Y(i,j) = I(y1,x2);
              else Y(i,j) = I(y2,x2); end
          end        
        end
    end
end

