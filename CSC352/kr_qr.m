function [Q,Q_hat,R,Rk] = kr_qr(F)
%  F: cell array of factors of coefficient KR prod
%  Q: cell array of factors QR's Q 
%  Q_hat: cell array of pairwise Q
%  R: upper triangular matrix 

d = length(F);
n = size(F{1},2);

Q = cell(d,1);
T = cell(d,1);
Q_hat = cell(d-1,1);

%QR on factor matrices
for i = 1:d
    [Q{i},T{i}] = qr(F{i},0);
end
Rk = khatrirao(T);

%QR on R
for i = 1:d-1
    [Q_hat{i},rr] = qr(khatrirao(T{i},T{i+1}),0);
    
    T{i+1} = rr;
end

R = rr;




end