
% 3-way ktensors 
%32
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




time31 = [part / 3 nort / 3 expt / 3];
%64
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

time32 = [part / 3 nort / 3 expt / 3];


%128
d = 3;
n = 128;
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

time33 = [part / 3 nort / 3 expt / 3];


%256

d = 3;
n = 256;
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

time34 = [part / 3 nort / 3 expt / 3];

figure,
x = [1:15];

bar(x,[time31 0 time32 0 time33 0 time34]);
title('3-way sine of sums ktensor');
ylabel('runtime (secs)')

xlabel('dimensions')
xticks([0:16]);
xticklabels({'','pairwise Elim','normal EQ','explicit QR','','pairwise Elim','normal EQ','explicit QR','','pairwise Elim','normal EQ','explicit QR','','pairwise Elim','normal EQ','explicit QR'})
v = -0.005;
text(2,v,'32','fontsize',10)
text(6,v,'64','fontsize',10)
text(10,v,'128','fontsize',10)
text(14,v,'256','fontsize',10)









% 
% 
% %4-way ktensor 
% d = 4;
% n = 40;
% expt = 0;
% nort = 0;
% part = 0;
% for w = 1:3
% %rng(1)
% T = sinsums(d,n);
% X = sinsum_full(d,n);
% true_err = norm(full(T) - full(X)) / norm(X)
% % generate random ktensor fac tors
% Ty = cell(d-1,1);
% Xy = cell(d-1,1);
% for i = 1 : d-1
%     Ty{i} = T.U{i};
%     Xy{i} = X.U{i};
% end
% 
% % generate random khatrirao factors
% tic
% K = khatrirao(Ty);
% kappa = cond(K)
% 
% XXX = K \ (khatrirao(Xy) * X.U{d}');
% T.U{d} = XXX';
% 
% exp_err = norm(full(T) - full(X)) / norm(X)
% expt = expt + toc
% 
% 
% 
% 
% 
% %test for normal equation
% %Grams
% tic
% G = Ty{1}'*Ty{1};
% for i = 2:d-1
%     G = G.*(Ty{i}'*Ty{i});
% end
% % precompute cross products with F
% C = Ty{1}'*Xy{1};
% for k=2:length(Xy)
%     C = C .* (Ty{k}'*Xy{k});
% end
% XX = (G \ C * X.U{d}')';
% T.U{d} = XX;
% 
% normal_err = norm(full(T) - full(X)) / norm(X)
% nort = nort + toc
% 
% 
% 
% 
% 
% %test for pairwise elimination
% tic
% [Qp,Qhatp,Rp] = kr_qr(Ty);
% D = apply_kr_qr(Qp,Qhatp,Xy,X.U{d});
% %condR = cond(Rp)
% XX = (Rp \ D)';
% T.U{d} = XX;
% 
% pairwise_err = norm(full(T) - full(X)) / norm(X)
% part = part +  toc
% end
% time41 = [part / 3 nort / 3 expt / 3];
% 
% 
% 
% 
% % n = 64
% d = 4;
% n = 64;
% expt = 0;
% nort = 0;
% part = 0;
% for w = 1:3
% %rng(1)
% T = sinsums(d,n);
% X = sinsum_full(d,n);
% true_err = norm(full(T) - full(X)) / norm(X)
% % generate random ktensor fac tors
% Ty = cell(d-1,1);
% Xy = cell(d-1,1);
% for i = 1 : d-1
%     Ty{i} = T.U{i};
%     Xy{i} = X.U{i};
% end
% 
% % generate random khatrirao factors
% tic
% K = khatrirao(Ty);
% kappa = cond(K)
% 
% XXX = K \ (khatrirao(Xy) * X.U{d}');
% T.U{d} = XXX';
% 
% exp_err = norm(full(T) - full(X)) / norm(X)
% expt = expt + toc
% 
% 
% 
% 
% 
% %test for normal equation
% %Grams
% tic
% G = Ty{1}'*Ty{1};
% for i = 2:d-1
%     G = G.*(Ty{i}'*Ty{i});
% end
% % precompute cross products with F
% C = Ty{1}'*Xy{1};
% for k=2:length(Xy)
%     C = C .* (Ty{k}'*Xy{k});
% end
% XX = (G \ C * X.U{d}')';
% T.U{d} = XX;
% 
% normal_err = norm(full(T) - full(X)) / norm(X)
% nort = nort + toc
% 
% 
% 
% 
% 
% %test for pairwise elimination
% tic
% [Qp,Qhatp,Rp] = kr_qr(Ty);
% D = apply_kr_qr(Qp,Qhatp,Xy,X.U{d});
% %condR = cond(Rp)
% XX = (Rp \ D)';
% T.U{d} = XX;
% 
% pairwise_err = norm(full(T) - full(X)) / norm(X)
% part = part +  toc
% end
% time42 = [part / 3 nort / 3 expt / 3];
% 
% 
% 
% 
% 
% 
% 
% 
% figure,
% x = [1:7];
% 
% bar(x,[time41 0 time42]);
% title('4-way sine of sums ktensor');
% ylabel('runtime (secs)')
% %ylim([0,0.01])
% xlabel('dimensions')
% xticks([0:8]);
% xticklabels({'','pairwise elimination','normal equation','explicit QR','','pairwise elimination','normal equation','explicit QR'})
% v = -0.05;
% text(2,v,'n=40','fontsize',10)
% text(6,v,'n=64','fontsize',10)
% 
% 
% 
% 
% % 
% % %%
% % figure,
% % X = categorical({'exp','normal equation','pairwise elimination',});
% % X = reordercats(X,{'exp','normal equation','pairwise elimination'});
% % bar(X,[time1  ]);
% % title('3-way, n = 32, 64');
% % ylabel('runtime (secs)')
% % ylim([0,0.01])
% % xlabel('dimension')
% % %%
% 
% 
% 
% 
% 
% 
% 
% 
% 
% 
