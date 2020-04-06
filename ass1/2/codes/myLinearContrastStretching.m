function imp = myLinearContrastStretching(input)
    [x,y,ch] = size(input);
    for k = 1:ch
        itemp = input(:,:,k);
        c = double(min(itemp,[],'ALL'));
        d = double(max(itemp, [], 'ALL'));
        temp2 = double(itemp);
        imp(:,:,k) = uint8(255*(temp2 - c)/(d - c));
    end
end