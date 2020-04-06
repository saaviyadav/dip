%% MyMainScript

tic;
%% Your code here
I = zeros(300);
I(50:100,50:120) = 255;
J = zeros(300);
J(20:70,120:190) = 255;
toc;
figure;
title('I');imshow(I);colorbar;
figure;
imshow(J);title('J');colorbar;

Ift = fftshift(fft2(I));
Jft = fftshift(fft2(J));
den = ((Ift.*Jft).*(conj(Ift.*Jft))).^0.5;
result = (Jft.*conj(Ift))./den;

res_ifft = ifftshift(ifft2(result));
figure;
imshow(log(abs(res_ifft)+1),[]); 
title('Log(Fourier magnitude of the cross-power spectrum)');
colorbar;

rmax = max(max(res_ifft));
[x , y] = find(res_ifft == rmax);
%%
Inew = I+20*randn(300);
Jnew = J+20*randn(300);
figure;
imshow(Inew);title('I with noise');colorbar;
figure;
imshow(Jnew);title('J with noise');colorbar;

Inewft = fftshift(fft2(Inew));
Jnewft = fftshift(fft2(Jnew));
den_N = ((Inewft.*Jnewft).*(conj(Inewft.*Jnewft))).^0.5;
result_N = (Jnewft.*conj(Inewft))./den_N;
res_ifft_N = ifftshift(ifft2(result_N));

figure;
imshow(log(abs(res_ifft_N)+1),[]);
title('Log(Fourier magnitude of the cross-power spectrum)');colorbar;

rmax_N = max(max(res_ifft_N));
[x_N , y_N] = find(res_ifft_N == rmax_N);