d = 5;
n = 50;


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
tic
K = khatrirao(Ty);
kappa = cond(K)

XXX = K \ (khatrirao(Xy) * X.U{d}');
T.U{d} = XXX';

exp_err = norm(full(T) - full(X)) / norm(X)






%test for normal equation
%Grams
tic
G = Ty{1}'*Ty{1};
for i = 2:d-1
    G = G.*(Ty{i}'*Ty{i});
end
% precompute cross products with F
C = Ty{1}'*Xy{1};
for k=2:length(Xy)
    C = C .* (Ty{k}'*Xy{k});
end
XX = (G \ C * X.U{d}')';
T.U{d} = XX;

normal_err = norm(full(T) - full(X)) / norm(X)
toc





%test for pairwise elimination
tic
[Qp,Qhatp,Rp] = kr_qr(Ty);
D = apply_kr_qr(Qp,Qhatp,Xy,X.U{d});
%condR = cond(Rp)
XX = (Rp \ D)';
T.U{d} = XX;

pairwise_err = norm(full(T) - full(X)) / norm(X)
toc










