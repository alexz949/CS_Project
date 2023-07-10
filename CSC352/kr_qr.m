function [Q,Q_hat,R] = kr_qr(F)
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

%QR on R
for i = 1:d-1
    %condP = cond(khatrirao(T{i},T{i+1}))
    [Q_hat{i},T{i+1}] = qr(khatrirao(T{i},T{i+1}),0);
    
    
end

R = T{d};

end