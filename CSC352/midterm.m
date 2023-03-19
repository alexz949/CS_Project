
%create matrix A that used for doing QR decomposition
A = vander(t);
A = A(:,end-4+1:end);

%For solving the least sqaure problem, we need to solve A'Ax = A'y. Doing
%the QR decomposition on A and gives us (QR)'QRx = (QR)'y equals 
%R'Q'QRx = R'Q'y. Since Q is orthogonal matrix, the equation can be
%transformed into R'Rx = R'Q'y, which Rx = Q'y, and x = Q'y \ R.
[Q,R] = qr(A);
y_1 = Q' * y;
x = R \ y_1;

%creating figure 
figure(1)
plot(t, y, t,A*x);
legend('Raw data','QR fit');
title('Curves for Raw Data and Fitted Line using QR Decomposition');
xlabel('t value');
ylabel('y value');
grid


