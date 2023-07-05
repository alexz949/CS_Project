% A = randn(7,3);
% B = randn(7,3);
% 
% 
% [QC,RC] = qr([A,B],0);
% n = size(A, 2);
% R = triu(RC(1:n, 1:n))
% C = RC(1:n, n+1:end)
% 
% testR = qr(A,0)
% RC
% inv(R) * C
% 
% ptRC = RC(:,1:3)

a = [1,2,3];
b = [4,5,6];
a = a';
a * b


