function ans = RMSE(imorig,im)
    [M,N] = size(im);
    ansNum = (imorig - double(im)).^2;
    ansNum = sum(sum(ansNum));
    ans = sqrt(ansNum/sum(imorig(:).^2));
end