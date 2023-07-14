
% 3-way ktensors 
%32
d = 3;
n = 32;
expt = 0;
nort = 0;
part = 0;
%rng(1)
T = sinsums(d,n);
X = sinsum_full(d,n);
true_err31 = norm(full(T) - full(X)) / norm(X)
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

exp_err31 = norm(full(T) - full(X)) / norm(X)
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

normal_err31 = norm(full(T) - full(X)) / norm(X)
nort = nort + toc





%test for pairwise elimination
tic
[Qp,Qhatp,Rp] = kr_qr(Ty);
D = apply_kr_qr(Qp,Qhatp,Xy,X.U{d});
%condR = cond(Rp)
XX = (Rp \ D)';
T.U{d} = XX;

pairwise_err31 = norm(full(T) - full(X)) / norm(X)
part = part +  toc










time31 = [true_err exp_err normal_err pairwise_err];
%64
d = 3;
n = 64;
expt = 0;
nort = 0;
part = 0;


%rng(1)
T = sinsums(d,n);
X = sinsum_full(d,n);
true_err32 = norm(full(T) - full(X)) / norm(X)
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

exp_err32 = norm(full(T) - full(X)) / norm(X)
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

normal_err32 = norm(full(T) - full(X)) / norm(X)
nort = nort + toc





%test for pairwise elimination
tic
[Qp,Qhatp,Rp] = kr_qr(Ty);
D = apply_kr_qr(Qp,Qhatp,Xy,X.U{d});
%condR = cond(Rp)
XX = (Rp \ D)';
T.U{d} = XX;

pairwise_err32 = norm(full(T) - full(X)) / norm(X)
part = part +  toc


time32 = [true_err exp_err normal_err pairwise_err];


%128
d = 3;
n = 128;
expt = 0;
nort = 0;
part = 0;

%rng(1)
T = sinsums(d,n);
X = sinsum_full(d,n);
true_err33 = norm(full(T) - full(X)) / norm(X)
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

exp_err33 = norm(full(T) - full(X)) / norm(X)
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

normal_err33 = norm(full(T) - full(X)) / norm(X)
nort = nort + toc





%test for pairwise elimination
tic
[Qp,Qhatp,Rp] = kr_qr(Ty);
D = apply_kr_qr(Qp,Qhatp,Xy,X.U{d});
%condR = cond(Rp)
XX = (Rp \ D)';
T.U{d} = XX;

pairwise_err33 = norm(full(T) - full(X)) / norm(X)
part = part +  toc


time33 = [true_err exp_err normal_err pairwise_err];


%256

d = 3;
n = 256;
expt = 0;
nort = 0;
part = 0;


%rng(1)
T = sinsums(d,n);
X = sinsum_full(d,n);
true_err34 = norm(full(T) - full(X)) / norm(X)
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

exp_err34 = norm(full(T) - full(X)) / norm(X)
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

normal_err34 = norm(full(T) - full(X)) / norm(X)
nort = nort + toc





%test for pairwise elimination
tic
[Qp,Qhatp,Rp] = kr_qr(Ty);
D = apply_kr_qr(Qp,Qhatp,Xy,X.U{d});
%condR = cond(Rp)
XX = (Rp \ D)';
T.U{d} = XX;

pairwise_err34 = norm(full(T) - full(X)) / norm(X)
part = part +  toc



timet = [true_err31 true_err32 true_err33 true_err34];
timee = [exp_err31 exp_err32 exp_err33 exp_err34];
timen = [normal_err31 normal_err32 normal_err33 normal_err34];
timep = [pairwise_err31 pairwise_err32 pairwise_err33 pairwise_err34];



figure,
x = [32 64 128 256];
plot(x,timet,x,timee,x,timen,x,timep)
legend('True err','Explicit QR err', 'Normal EQ err', 'Pairwise Elim err')
ylim([1e-12 1e-9])
ylabel('relative residual')
xlabel('dimensions')
title('3-way ktensor, K = 4e5')











