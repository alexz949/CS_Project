function [Q,Q_hat,R,testR] = kr_qr(F)
%  F: cell array of factors of coefficient KR prod
%  Q: cell array of factors QR's Q 
%  Q_hat: cell array of pairwise Q
%  R: upper triangular matrix 


%Suppose F is a cell array which one of  its entry is 0
%I want to skip that 0 entry for Q but shrink for Q_hat

%length with that 0 entry
d = length(F);

%Q for factor matrice
Q = cell(d,1);

%set of R for factor matrix
T = cell(d,1);


%showed be shinked
Q_hat = cell(d-1,1);

%QR on factor matrices not shrinked
for i = 1:d
        [Q{i},T{i}] = qr(F{i},0);
end



%shrink array R
tc = cell(d-1,1);
j = 1;
for i = 1:d
    if ~isempty(T{i})
        tc{j} = T{i};
        j = j+1;
    end
end

testR = khatrirao(tc);

% [testq,testR] = qr(testR,0);


%QR on R on reverse order
for i = d-1:-1:2
    %condP = cond(khatrirao(T{i},T{i+1}))
    
    [Q_hat{i},tc{i-1}] = qr(khatrirao(tc{i},tc{i-1}),0);
    
end

R = tc{1};
% 
% normR = norm(R - testR) / norm(testR)









end