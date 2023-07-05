% I = 30; J = 14; K = 15; L = 17; R = 3; S = 10;
% U = randn(I,R); V = randn(J,R); W = randn(K,R); Y = randn(L,R);
% A = randn(I,S); B = randn(J,S); C = randn(K,S); D = randn(L,S);
d = 5;
n = 32;
T = sinsums(d,n);
X = sinsum_full(d,n);



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

% exp error 
XXX = K \ (khatrirao(Xy) * X.U{d}');
T.U{d} = XXX';
exp_err = norm(full(T) - full(X)) / norm(X)



[Qw,RR] = mgs_khatrirao(Ty);
[QL, RL] = mgsleft1(khatrirao(Ty));
% test QR factorization
K = khatrirao(Ty);
[qq,rr] = qr(K,0);
Q = K;
for i = 1:d
    Q(:,i) = reshape(double(full(ktensor(Qw(:,i),Ty))),[],1);
end



[XX,expQ,expR] = hhqr_quasi_exp(Ty,Xy,X.U{d});
[XX,L,M,R,LQ,MQ,LA,MA,Qhh] = hhqr_quasi_orth(Ty,Xy,X.U{d});










Qtb = Q' * khatrirao(Xy) * X.U{d}';


XX =  (R \ Qtb)';
%XX = (Qw * Qtb)';



% imp error
T.U{d} = XX;
imp_err = norm(full(T) - full(X)) / norm(X)



norm(K-Q*RR)/norm(K)
norm(abs(Q)-abs(qq))

% % test least squares solve
% YY = mgs_khatrirao_ls({U,V,W},{A,B,C},D);
% BB = khatrirao(C,B,A)*D';
% yy = BB' / KK';
% norm(YY-yy)/norm(yy)