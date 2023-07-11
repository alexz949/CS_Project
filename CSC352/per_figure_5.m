
% 5-way ktensors 
%30
d = 5;
n = 30;
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




time51 = [part / 3 nort / 3 expt / 3];
%60
d = 5;
n = 60;
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

time52 = [part / 3 nort / 3 expt / 3];


%90
d = 5;
n = 90;
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

time53 = [part / 3 nort / 3 expt / 3];


%120

d = 5;
n = 120;
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

time54 = [part / 3 nort / 3 expt / 3];

figure,
x = [1:15];

bar(x,[time51 0 time52 0 time53 0 time4]);
title('4-way sine of sums ktensor');
ylabel('runtime (secs)')

xlabel('dimensions')
xticks([0:16]);
xticklabels({'','pairwise Elim','normal EQ','explicit QR','','pairwise Elim','normal EQ','explicit QR','','pairwise Elim','normal EQ','explicit QR','','pairwise Elim','normal EQ','explicit QR'})
v = -0.05;
text(2,v,'30','fontsize',10)
text(6,v,'60','fontsize',10)
text(10,v,'90','fontsize',10)
text(14,v,'120','fontsize',10)
