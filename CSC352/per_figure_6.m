
% 5-way ktensors 
%30
d = 6;
n = 15;
expt = 0;
nort = 0;
part = 0;

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




time51 = [part nort expt];
%60
d = 6;
n = 20;
expt = 0;
nort = 0;
part = 0;


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


time52 = [part nort expt];


%90
d = 6;
n = 25;
expt = 0;
nort = 0;
part = 0;


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


time53 = [part  nort expt ];


%120

d = 6;
n = 30;
expt = 0;
nort = 0;
part = 0;


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


time54 = [part  nort  expt ];

figure,
x = [1:15];

bar(x,[time51 0 time52 0 time53 0 time54]);
title('6-way sine of sums ktensor');
ylabel('runtime (secs)')

xlabel('dimensions')
xticks([0:16]);
xticklabels({'','pairwise Elim','normal EQ','explicit QR','','pairwise Elim','normal EQ','explicit QR','','pairwise Elim','normal EQ','explicit QR','','pairwise Elim','normal EQ','explicit QR'})
v = -2;
text(2,v,'15','fontsize',10)
text(6,v,'20','fontsize',10)
text(10,v,'25','fontsize',10)
text(14,v,'30','fontsize',10)
