%% MyMainScript
clc; clear;
A = randn(3,3);
[u,s,v] = MySVD(A);
[U,S,V] = svd(A);

if sum(sum(abs(u*s*v'-A))) < 0.0005
    display('matched');
end
tic;
%% Your code here
function [U,S,V] = MySVD(A)
    if size(A,1) > size(A,2)
        [U,~] = eig(A*A');
        [V,D] = eig(A'*A);
    else 
        [U,D] = eig(A*A');
        [V,~] = eig(A'*A);
    end
    V = flip(V,2);
    U = flip(U,2);
    D = fliplr(fliplr(D)');
    s = D.^0.5;
    S = zeros(size(A));
    S(1:size(s,1),1:size(s,1)) = s;
    U = U - 2*U.*(checkEqual(A*V,U*S));
end

function check = checkEqual( a,b )
    check = zeros(size(a,1),size(a,1));
    c = abs(a-b)>0.005;
    check(1:min(size(c,1),size(check,1)),1:min(size(c,2),size(check,2))) = c(1:min(size(c,1),size(check,1)),1:min(size(c,2),size(check,2)));
end