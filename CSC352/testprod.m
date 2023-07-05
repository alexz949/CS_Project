I = 30; J = 14; K = 15; L = 17; R = 3; S = 10;
U = randn(I,R); V = randn(J,R); W = randn(K,R); Y = randn(L,R);
A = randn(I,S); B = randn(J,S); C = randn(K,S); D = randn(L,S);
d = 4;
n = 32;
%F = {U,V,W};
T = sinsums(d,n);
F = cell(d-1,1);


for i = 1 : d
    F{i} = T.U{i};
end


L = randn(size(F{1},2),1);
M = randn(size(F{1},2),1);


G = F{1}'*F{1};
for i = 2:d
    G = G.*(F{i}'*F{i});
end
F_hat = khatrirao(F);
[qq,rr] = qr(F_hat,0);
rinv = inv(rr);
L = rinv(:,end-1);
M = zeros(size(L)); M(end) = 1;



expProd = (F_hat*L)' * (F_hat*M)
impProd = myp(L, G,M)
prescaleProd = mydot(L,F,M)

old_err = abs(expProd - impProd) / abs(expProd)
new_err = abs(expProd - prescaleProd) / abs(expProd)




function d = myp(lambda, G, mu)
    d = lambda' * G * mu;
end

function d = mydot(lambda,F,mu)

    K = ktensor(lambda,F);
    m = ncomponents(K);
    G = tocell(K);
    h = ones(m,1);
    for jj = 1:length(G)
        h = h .* (G{jj}'*F{jj});
    end
    h = h* mu;
   
    d = sum(h);
end