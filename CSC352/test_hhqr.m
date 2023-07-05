% test hhqr_quasi_ls
clear

d = 3;
n = 5;
r = 3;
s = 4;

rng(1)

% generate random ktensor fac tors
TU = cell(d-1,1);
for i = 1:d-1
    %TU{i} = T.U{i};
    TU{i} = randn(n,s);
end
TUend = randn(n,s);
KT = khatrirao(TU);
B = KT*TUend';

% generate random khatrirao factors
F = cell(1,d-1);
for i = 1:d-1
    F{i} =TU{i};
    %F{i} = TU{i};
end


%%
[X,L,M,R,LQ,MQ,LA,MA,Q,testQ] = hhqr_quasi_mat(F,TU,TUend);

K = khatrirao(F);

[Qk,Rk] = qr(K,0);

% Qw = inv(R);
% QQ = K;
% for i = 1:size(Qw,2)
%     QQ(:,i) = reshape(double(full(ktensor(Qw(:,i),F))),[],1);
% end

bckerr = norm(K-Qk*Rk)/norm(K)
bckerr_chol = norm(K-Q*R)/norm(K)
qcomp = norm(abs(Qk)-abs(Q))/norm(Qk)
rcomp = norm(abs(Rk)-abs(R))/norm(Rk)

% LS test
xtrue = B' / K';

err_xchol = norm(X-xtrue)/norm(xtrue)

residual = norm(K*X' - B)/norm(B)