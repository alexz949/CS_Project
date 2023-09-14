%%
load decathlon 
[nathletes,nevents] = size(points);
%%

[coeff,score,~,~,explained,mu] = pca(raw);
[U,S,V] = svd(raw-mu,0);

normV = norm(coeff - V) / norm(coeff)
normU = norm(score - U*S) / norm(score)

