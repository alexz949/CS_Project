A = randn(5,3);
B = randn(5,3);
C = randn(5,3);
E = randn(5,3);
F = {A,B,C};
[Q,Q_hat,R,Rk] = kr_qr(F);


X = {A,B,C};
[D,testB] = apply_kr_qr(Q,Q_hat,X,eye(5,3));

atrue = Rk \ testB





Ft = khatrirao(A,B,C);
[Qt,Rt] = qr(Ft,0);
Qtb = Qt' * Ft;



R_err = norm(abs(Rt) - abs(R))/ norm(abs(R))
R
Rt

atest = (R \ D)

