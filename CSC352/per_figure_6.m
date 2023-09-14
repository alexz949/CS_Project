%%
% 5-way ktensors 
%30
d = 6;
n = 50000;
t_krp = 0;
t_back = 0;
t_gram = 0;
t_comp = 0;
t_comp_apply = 0;
t_par = 0;
t_par_apply = 0;
t_apply = 0;


%rng(1)
T = sinsums(d,n);
X = sinsum_full(d,n);
%true_err = norm(full(T) - full(X)) / norm(X)
% generate random ktensor fac tors
Ty = cell(d-1,1);
Xy = cell(d-1,1);
for i = 1 : d-1
    Ty{i} = T.U{i};
    Xy{i} = X.U{i};
end

% % generate random khatrirao factors
% tic
% K = khatrirao(Ty);
% Kx = khatrirao(Xy);
% t = toc; t_krp = t_krp + t;
% tic
% [Qk,Rk] = qr(K,0);
% t = toc; t_comp = t_comp + t;
% kappa = cond(K)
% tic
% Kx = Qk' * Kx;
% t = toc; t_apply = t_apply + t;
% tic
% XXX = Rk \ (Kx * X.U{d}');
% T.U{d} = XXX';
% t = toc; t_back = t_back + t;
% 
% exp_err = norm(full(T) - full(X)) / norm(X)
% 
 expt = [t_krp, t_comp,t_comp_apply,t_par,t_par_apply,t_apply,t_back];

t_krp = 0;
t_back = 0;
t_gram = 0;
t_comp = 0;
t_comp_apply = 0;
t_par = 0;
t_par_apply = 0;
t_apply = 0;

%test for normal equation
%Grams
tic
G = Ty{1}'*Ty{1};
for i = 2:d-1
    G = G.*(Ty{i}'*Ty{i});
end
t = toc; t_gram = t_gram + t;
% precompute cross products with F
tic
C = Ty{1}'*Xy{1};
for k=2:length(Xy)
    C = C .* (Ty{k}'*Xy{k});
end
t = toc; t_apply = t_apply + t;

tic
% XX = (G \ C * X.U{d}')';
% T.U{d} = XX;
T.U{d} = X.U{d} * (C' / G);
t = toc; t_back = t_back + t;

%normal_err = norm(full(T) - full(X)) / norm(X)

nort = [t_krp, t_comp,t_comp_apply,t_par,t_par_apply,t_apply,t_back];


t_krp = 0;
t_back = 0;
t_gram = 0;
t_comp = 0;
t_comp_apply = 0;
t_par = 0;
t_par_apply = 0;
t_apply = 0;



%test for pairwise elimination

[Qp,Qhatp,Rp,ttc,ttp] = kr_qr(Ty);


[D,tttc,tttp] = apply_kr_qr(Qp,Qhatp,Xy,X.U{d});

%condR = cond(Rp)

tic
XX = (Rp \ D)';
T.U{d} = XX;
t = toc; t_back = t_back+t;

t_comp = ttc;
t_comp_apply = ttp;
t_par = tttc;
t_par_apply = tttp;
%pairwise_err = norm(full(T) - full(X)) / norm(X)

part = [t_krp, t_comp,t_par,t_comp_apply,t_par_apply,t_apply,t_back];




time51 = [part ;nort; expt];



%%
% 5-way ktensors 
%30
d = 6;
n = 60000;
t_krp = 0;
t_back = 0;
t_gram = 0;
t_comp = 0;
t_comp_apply = 0;
t_par = 0;
t_par_apply = 0;
t_apply = 0;


%rng(1)
T = sinsums(d,n);
X = sinsum_full(d,n);
%true_err = norm(full(T) - full(X)) / norm(X)
% generate random ktensor fac tors
Ty = cell(d-1,1);
Xy = cell(d-1,1);
for i = 1 : d-1
    Ty{i} = T.U{i};
    Xy{i} = X.U{i};
end

% % generate random khatrirao factors
% tic
% K = khatrirao(Ty);
% Kx = khatrirao(Xy);
% t = toc; t_krp = t_krp + t;
% tic
% [Qk,Rk] = qr(K,0);
% t = toc; t_comp = t_comp + t;
% kappa = cond(K)
% tic
% Kx = Qk' * Kx;
% t = toc; t_apply = t_apply + t;
% tic
% XXX = Rk \ (Kx * X.U{d}');
% T.U{d} = XXX';
% t = toc; t_back = t_back + t;
% 
% exp_err = norm(full(T) - full(X)) / norm(X)
% 
 expt = [t_krp, t_comp,t_comp_apply,t_par,t_par_apply,t_apply,t_back];

t_krp = 0;
t_back = 0;
t_gram = 0;
t_comp = 0;
t_comp_apply = 0;
t_par = 0;
t_par_apply = 0;
t_apply = 0;

%test for normal equation
%Grams
tic
G = Ty{1}'*Ty{1};
for i = 2:d-1
    G = G.*(Ty{i}'*Ty{i});
end
t = toc; t_gram = t_gram + t;
% precompute cross products with F
tic
C = Ty{1}'*Xy{1};
for k=2:length(Xy)
    C = C .* (Ty{k}'*Xy{k});
end
t = toc; t_apply = t_apply + t;

tic
% XX = (G \ C * X.U{d}')';
% T.U{d} = XX;
T.U{d} = X.U{d} * (C' / G);
t = toc; t_back = t_back + t;

%normal_err = norm(full(T) - full(X)) / norm(X)

nort = [t_krp, t_gram,t_comp_apply,t_par,t_par_apply,t_apply,t_back];


t_krp = 0;
t_back = 0;
t_gram = 0;
t_comp = 0;
t_comp_apply = 0;
t_par = 0;
t_par_apply = 0;
t_apply = 0;



%test for pairwise elimination

[Qp,Qhatp,Rp,ttc,ttp] = kr_qr(Ty);


[D,tttc,tttp] = apply_kr_qr(Qp,Qhatp,Xy,X.U{d});

%condR = cond(Rp)

tic
XX = (Rp \ D)';
T.U{d} = XX;
t = toc; t_back = t_back+t;

t_comp = ttc;
t_comp_apply = ttp;
t_par = tttc;
t_par_apply = tttp;
%pairwise_err = norm(full(T) - full(X)) / norm(X)

part = [t_krp, t_comp,t_par,t_comp_apply,t_par_apply,t_apply,t_back];




time52 = [part ;nort; expt];



%%
% 5-way ktensors 
%30
d = 6;
n = 70000;
t_krp = 0;
t_back = 0;
t_gram = 0;
t_comp = 0;
t_comp_apply = 0;
t_par = 0;
t_par_apply = 0;
t_apply = 0;


%rng(1)
T = sinsums(d,n);
X = sinsum_full(d,n);
%true_err = norm(full(T) - full(X)) / norm(X)
% generate random ktensor fac tors
Ty = cell(d-1,1);
Xy = cell(d-1,1);
for i = 1 : d-1
    Ty{i} = T.U{i};
    Xy{i} = X.U{i};
end

% % generate random khatrirao factors
% tic
% K = khatrirao(Ty);
% Kx = khatrirao(Xy);
% t = toc; t_krp = t_krp + t;
% tic
% [Qk,Rk] = qr(K,0);
% t = toc; t_comp = t_comp + t;
% kappa = cond(K)
% tic
% Kx = Qk' * Kx;
% t = toc; t_apply = t_apply + t;
% tic
% XXX = Rk \ (Kx * X.U{d}');
% T.U{d} = XXX';
% t = toc; t_back = t_back + t;
% 
% exp_err = norm(full(T) - full(X)) / norm(X)
% 
 expt = [t_krp, t_gram,t_comp_apply,t_par,t_par_apply,t_apply,t_back];

t_krp = 0;
t_back = 0;
t_gram = 0;
t_comp = 0;
t_comp_apply = 0;
t_par = 0;
t_par_apply = 0;
t_apply = 0;

%test for normal equation
%Grams
tic
G = Ty{1}'*Ty{1};
for i = 2:d-1
    G = G.*(Ty{i}'*Ty{i});
end
t = toc; t_gram = t_gram + t;
% precompute cross products with F
tic
C = Ty{1}'*Xy{1};
for k=2:length(Xy)
    C = C .* (Ty{k}'*Xy{k});
end
t = toc; t_apply = t_apply + t;

tic
% XX = (G \ C * X.U{d}')';
% T.U{d} = XX;
T.U{d} = X.U{d} * (C' / G);
t = toc; t_back = t_back + t;

%normal_err = norm(full(T) - full(X)) / norm(X)

nort = [t_krp, t_gram,t_comp_apply,t_par,t_par_apply,t_apply,t_back];


t_krp = 0;
t_back = 0;
t_gram = 0;
t_comp = 0;
t_comp_apply = 0;
t_par = 0;
t_par_apply = 0;
t_apply = 0;



%test for pairwise elimination

[Qp,Qhatp,Rp,compQ,pairQ] = kr_qr(Ty);


[D,qtb,pairRHS] = apply_kr_qr(Qp,Qhatp,Xy,X.U{d});

%condR = cond(Rp)

tic
XX = (Rp \ D)';
T.U{d} = XX;
t = toc; t_back = t_back+t;

t_comp = compQ;
t_comp_apply = pairQ;
t_par = qtb;
t_par_apply = pairRHS;
%pairwise_err = norm(full(T) - full(X)) / norm(X)

part = [t_krp, t_comp,t_par,t_comp_apply,t_par_apply,t_apply,t_back];




time53 = [part ;nort; expt];





%%
% 5-way ktensors 
%30
d = 6;
n = 80000;
t_krp = 0;
t_back = 0;
t_gram = 0;
t_comp = 0;
t_comp_apply = 0;
t_par = 0;
t_par_apply = 0;
t_apply = 0;


%rng(1)
T = sinsums(d,n);
X = sinsum_full(d,n);
%true_err = norm(full(T) - full(X)) / norm(X)
% generate random ktensor fac tors
Ty = cell(d-1,1);
Xy = cell(d-1,1);
for i = 1 : d-1
    Ty{i} = T.U{i};
    Xy{i} = X.U{i};
end

% % generate random khatrirao factors
% tic
% K = khatrirao(Ty);
% Kx = khatrirao(Xy);
% t = toc; t_krp = t_krp + t;
% tic
% [Qk,Rk] = qr(K,0);
% t = toc; t_comp = t_comp + t;
% kappa = cond(K)
% tic
% Kx = Qk' * Kx;
% t = toc; t_apply = t_apply + t;
% tic
% XXX = Rk \ (Kx * X.U{d}');
% T.U{d} = XXX';
% t = toc; t_back = t_back + t;
% 
% exp_err = norm(full(T) - full(X)) / norm(X)
% 
 expt = [t_krp, t_comp,t_comp_apply,t_par,t_par_apply,t_apply,t_back];

t_krp = 0;
t_back = 0;
t_gram = 0;
t_comp = 0;
t_comp_apply = 0;
t_par = 0;
t_par_apply = 0;
t_apply = 0;

%test for normal equation
%Grams
tic
G = Ty{1}'*Ty{1};
for i = 2:d-1
    G = G.*(Ty{i}'*Ty{i});
end
t = toc; t_gram = t_gram + t;
% precompute cross products with F
tic
C = Ty{1}'*Xy{1};
for k=2:length(Xy)
    C = C .* (Ty{k}'*Xy{k});
end
t = toc; t_apply = t_apply + t;

tic
% XX = (G \ C * X.U{d}')';
% T.U{d} = XX;
T.U{d} = X.U{d} * (C' / G);
t = toc; t_back = t_back + t;

%normal_err = norm(full(T) - full(X)) / norm(X)

nort = [t_krp, t_gram,t_comp_apply,t_par,t_par_apply,t_apply,t_back];


t_krp = 0;
t_back = 0;
t_gram = 0;
t_comp = 0;
t_comp_apply = 0;
t_par = 0;
t_par_apply = 0;
t_apply = 0;



%test for pairwise elimination

[Qp,Qhatp,Rp,ttc,ttp] = kr_qr(Ty);


[D,tttc,tttp] = apply_kr_qr(Qp,Qhatp,Xy,X.U{d});

%condR = cond(Rp)

tic
XX = (Rp \ D)';
T.U{d} = XX;
t = toc; t_back = t_back+t;
%compute factor QR
t_comp = ttc;
%pairwise QR
t_comp_apply = ttp;
%qtb
t_par = tttc;
%pairwise qtb
t_par_apply = tttp;
%pairwise_err = norm(full(T) - full(X)) / norm(X)

part = [t_krp, t_comp,t_par,t_comp_apply,t_par_apply,t_apply,t_back];




time54 = [part ;nort; expt];
%%
%%add space between figure
 time51 = [time51(1:2,:);0 0 0 0 0 0 0];
 time52 = [time52(1:2,:);0 0 0 0 0 0 0];
 time53 = [time53(1:2,:);0 0 0 0 0 0 0];
 time54 = [time54(1:2,:);0 0 0 0 0 0 0];
 sixway = struct;
 ft = size(time51,1);
 st = size(time51,2);
 sixway.t1 = zeros(ft,st);
 sixway.t2 = zeros(ft,st);
 sixway.t3 = zeros(ft,st);
 sixway.t4 = zeros(ft,st);
 sixway.t1 = time51;
 sixway.t2 = time52;
 sixway.t3 = time53;
 sixway.t4 = time54;
 save('sixway.mat','sixway');
%%
figure,

load('sixway.mat', 'sixway');

bar([sixway.t1; sixway.t2; sixway.t3; sixway.t4],'stacked');
title('6-way sine of sums ktensor');
ylabel('runtime (secs)')

xlabel('dimensions')
xticks([0:12]);
xticklabels({'','pairwise Elim','normal EQ','','pairwise Elim','normal EQ','','pairwise Elim','normal EQ','','pairwise Elim','normal EQ'})
v = -0.0002;
text(1,v,'50000','fontsize',10)
text(4,v,'60000','fontsize',10)
text(7,v,'70000','fontsize',10)
text(10,v,'80000','fontsize',10)
legend('KRP','Gram/QR','Qtb','Apply QR','Pairwise RHS','Atb','Back','fontsize',16)
