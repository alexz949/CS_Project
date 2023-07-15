A = randn(9,3);
B = randn(9,3);
C = randn(9,3);
F = cell(4,1);
F{1} = A;
F{2} = B;
F{3} = C;


%QR for each factor matrix
[Q,Q_hat,R] = kr_qr(F);

%Qtb 
X = F;
D = apply_kr_qr(Q,Q_hat,X,randn(5,3));


%exp Qtb
Ft = khatrirao(A,B,C);
[Qt,Rt] = qr(Ft,0);
Qtb = Qt' * Ft;


R_err = norm(abs(Rt) - abs(R))/ norm(abs(R))

%I think if everything is true this should give out an identity matrix
unit_test = (R \ D)