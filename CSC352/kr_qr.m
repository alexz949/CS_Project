function [Q,Q_hat,R,testR] = kr_qr(F)
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
    if ~isempty(F{i})
        [Q{i},T{i}] = qr(F{i},0);
    end
end

tc = cell(d-1,1);
j = 1;
for i = 1:d
    if ~isempty(T{i})
        tc{j} = T{i};
        j = j+1;
    end
end
tc
% testR = khatrirao(tc,'r');
% [testq,testR] = qr(testR,0);

%QR on R
for i = d-1:-1:2
    %condP = cond(khatrirao(T{i},T{i+1}))
    
    [Q_hat{i},tc{i-1}] = qr(khatrirao(tc{i},tc{i-1}),0);
end

R = tc{1};
% 
% normR = norm(R - testR) / norm(testR)


end