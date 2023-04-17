function T1 = HOSVD(X,r1,r2,r3)
[U1,S1,V1] = svd(unfold(X,1));
U1 = U1(:,1:r1);
[U2,S2,V2] = svd(unfold(X,2));
U2 = U2(:,1:r2);
[U3,S3,V3] = svd(unfold(X,3));
U3 = U3(:,1:r3);
g = ttm(X, {U1',U2',U3'});
T1 = ttensor(g,U1,U2,U3);
end