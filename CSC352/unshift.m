
A = rand(10,10);
 
for k = 1:1000000
    [Q,R] = qr(A);
    A = R* Q;
end
disp(A);