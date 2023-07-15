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
[D,qtb_KRP] = apply_kr_qr(Q,Q_hat,X,eye(3,3));
testQ = cell(4-1,1);
for i = 1:3
    testQ{i} = Q{i}' * X{i};
    
end
check = khatrirao(testQ,'r');

normQtb = norm(check - qtb_KRP) / norm(check) 


%exp Qtb
Ft = khatrirao(A,B,C, 'r');
[Qt,Rt] = qr(Ft,0);
Qtb = Qt' * Ft * eye(3,3)';

normZ = norm(Qtb - D)/ norm(Qtb)


R_err = norm(abs(Rt) - abs(R))/ norm(abs(R))

%I think if everything is true this should give out an identity matrix
unit_test = (R \ D)