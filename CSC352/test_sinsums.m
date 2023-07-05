d = 5;
n = 32;
% %beta = pi * ((d-1)/d);
% a = linspace(0,pi * ((d-1)/d),d);
% T = sinsums(d,n);
% 
% 



% test hhqr_quasi_ls

%d = 5;
%n = 5;
%r = 5;
%s = 5;

%rng(1)
T = sinsums(d,n);
X = sinsum_full(d,n);
true_err = norm(full(T) - full(X)) / norm(X)
% generate random ktensor fac tors
Ty = cell(d-1,1);
Xy = cell(d-1,1);
for i = 1 : d-1
    Ty{i} = T.U{i};
    Xy{i} = X.U{i};
end
% generate random khatrirao factors
K = khatrirao(Ty);
kappa = cond(K)

XXX = K \ (khatrirao(Xy) * X.U{d}');
T.U{d} = XXX';
exp_err = norm(full(T) - full(X)) / norm(X)




%%
%[XX,L,M,R,LQ,MQ,LA,MA,Q] = hhqr_quasi_hh(Ty,Xy,X.U{d});


% H = Ty{1}'*Xy{1};
% for i = 2:d-1
%     H = H .* (Ty{i}'*Xy{i});
% end
% Atb = H * X.U{d}';
% XX = V * inv(S).^2 * V' * Atb;

[XX,expQ,expR,expV] = hhqr_quasi_exp(Ty,Xy,X.U{d});

%[XX,L,M,R,LQ,MQ,LA,MA,Q,V] = hhqr_quasi_orth(Ty,Xy,X.U{d});
T.U{d} = XX;
imp_err = norm(full(T) - full(X)) / norm(X)




% K = khatrirao(F);
% 
% [Qk,Rk] = qr(K,0);
% 
% % Qw = inv(R);
% % QQ = K;
% % for i = 1:size(Qw,2)
% %     QQ(:,i) = reshape(double(full(ktensor(Qw(:,i),F))),[],1);
% % end
% 
% bckerr = norm(K-Qk*Rk)/norm(K)
% bckerr_chol = norm(K-Q*R)/norm(K)
% qcomp = norm(abs(Qk)-abs(Q))/norm(Qk)
% rcomp = norm(abs(Rk)-abs(R))/norm(Rk)
% 
% % LS test
% xtrue = B' / K';
% 
% err_xchol = norm(X-xtrue)/norm(xtrue)
% 
% residual = norm(K*X' - B)/norm(B)
