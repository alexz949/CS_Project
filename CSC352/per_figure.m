d = 3;
n = 32;
expt = 0;
nort = 0;
part = 0;
for w = 1:3
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
expt = expt + toc





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
nort = nort + toc





%test for pairwise elimination
tic
[Qp,Qhatp,Rp] = kr_qr(Ty);
D = apply_kr_qr(Qp,Qhatp,Xy,X.U{d});
%condR = cond(Rp)
XX = (Rp \ D)';
T.U{d} = XX;

pairwise_err = norm(full(T) - full(X)) / norm(X)
part = part +  toc
end




time1 = [expt / 3 nort / 3 part / 3];
d = 3;
n = 64;
expt = 0;
nort = 0;
part = 0;

for w = 1:3
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
expt = expt + toc





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
nort = nort + toc





%test for pairwise elimination
tic
[Qp,Qhatp,Rp] = kr_qr(Ty);
D = apply_kr_qr(Qp,Qhatp,Xy,X.U{d});
%condR = cond(Rp)
XX = (Rp \ D)';
T.U{d} = XX;

pairwise_err = norm(full(T) - full(X)) / norm(X)
part = part +  toc
end

time2 = [expt / 3 nort / 3 part / 3];




figure,
x = [1:7];
ax = gca;
ax.FontSize = 16;
bar(x,[time1 0 time2],'grouped');
title('3-way, n = 32, 64');
ylabel('runtime (secs)')
ylim([0,0.01])
xlabel('dimension')
xticks([0:8]);
xticklabels({'','exp','normal equation','pairwise elimination','','exp','normal equation','pairwise elimination'})





%%
figure,
X = categorical({'exp','normal equation','pairwise elimination',});
X = reordercats(X,{'exp','normal equation','pairwise elimination'});
bar(X,[time1  ]);
title('3-way, n = 32, 64');
ylabel('runtime (secs)')
ylim([0,0.01])
xlabel('dimension')
%%










