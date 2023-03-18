%Creating true R
T = randn(100);
R = triu(T);

%Creating true Q
[Q,U] = qr(randn(100));

%Creating A
A = Q*R;

%Do QR factorization on A
[Q1,R1] = qr(A);

%calculating relative error
a = norm(Q1-Q)/norm(Q);
disp(a);
b = norm(R1-R)/norm(R);
disp(b);

sta = norm(Q1*R1- Q*R)/norm(Q*R);
disp(sta);