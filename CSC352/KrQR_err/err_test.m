d = 6;
timet=[];
timee=[];
timen=[];
timep=[];
t = 16;
six_way_err = zeros(t,5);

for w = 1:t
n = w+4
expt = 0;
nort = 0;
part = 0;
%rng(1)
T = sinsums(d,n);
X = sinsum_full(d,n);
true_err31 = norm(full(T) - full(X)) / norm(X);
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
kappa = cond(K);

XXX = K \ (khatrirao(Xy) * X.U{d}');
T.U{d} = XXX';

exp_err31 = norm(full(T) - full(X)) / norm(X);
expt = expt + toc;





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

normal_err31 = norm(full(T) - full(X)) / norm(X);
nort = nort + toc;





%test for pairwise elimination
tic
[Qp,Qhatp,Rp] = kr_qr(Ty);
D = apply_kr_qr(Qp,Qhatp,Xy,X.U{d});
%condR = cond(Rp)
XX = (Rp \ D)';
T.U{d} = XX;

pairwise_err31 = norm(full(T) - full(X)) / norm(X);
part = part +  toc;

timet = [timet true_err31];
timee = [timee exp_err31];
timen = [timen normal_err31];
timep = [timep pairwise_err31];
six_way_err(w,2) = true_err31;
six_way_err(w,3) = exp_err31;
six_way_err(w,4) = normal_err31;
six_way_err(w,5) = pairwise_err31;


end
size(timet)
for w = 1:t
    six_way_err(w,1) = w +4;
end

save("six_way_err.mat", "six_way_err");

% 
% figure,
% 
% semilogy(x,timet,x,timee,x,timen,x,timep)
% legend('True err','Explicit QR err', 'Normal EQ err', 'Pairwise Elim err')
% 
% ylabel('relative residual')
% xlabel('dimensions')
% title('3-way ktensor, K = 4e5')


