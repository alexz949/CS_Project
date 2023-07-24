function [Q,R] = kr_qr(F)
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




%QR on factor matrices not shrinked
for i = 1:d
        [Q{i},T{i}] = qr(F{i},0);
end
R = T;

% 
% normR = norm(R - testR) / norm(testR)









end