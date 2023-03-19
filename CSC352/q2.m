%initialize
A = [0.7*ones(20,1),ones(20,1)];
for a = 10:20
    A(a,1) = A(a,1)+ 10^(-10);
end

%compute QR
[Q,R] = qr(A);
[Q1,R1] = mgs(A);

%check orthogonality
q = norm(Q'*Q-eye(20));
q1 = norm(Q1*Q1'-eye(20));

disp(q);
disp(q1);
