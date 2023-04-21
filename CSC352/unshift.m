e = eig(A);
B = A;
for k = 1:10
    [Q,R] = qr(B);
    B = R* Q;
end
disp(B);
x = [];
for i = 1:13
    x = [x, B(i,i)];
end
b = [];
for i = 1:13
    b = [b,i];
end
x = sort(x);
e = e';



%%%%%%%%%%%%%
for k = 1:100
    [Q,R] = qr(B);
    B = R* Q;
end

x1 = [];
for i = 1:13
    x1 = [x1, B(i,i)];
end
b = [];
for i = 1:13
    b = [b,i];
end
x1 = sort(x1);


%%%%%%%%%%%%%
for k = 1:300
    [Q,R] = qr(B);
    B = R* Q;
end

x2 = [];
for i = 1:13
    x2 = [x2, B(i,i)];
end
b = [];
for i = 1:13
    b = [b,i];
end
x2 = sort(x2);



%%%%%%%%%%%%%
for k = 1:1000
    [Q,R] = qr(B);
    B = R* Q;
end

x3 = [];
for i = 1:13
    x3 = [x3, B(i,i)];
end
b = [];
for i = 1:13
    b = [b,i];
end
x3 = sort(x3);


figure
subplot(1,2,1)
plot(b,e,b,x)
title("dim = 13, iteration = 10")
legend("built-in","iterative");



subplot(1,2,2)
plot(b,e,b,x1);
title("dim = 13, iteration = 100");
legend("built-in","iterative");

figure
subplot(1,2,1)
plot(b,e,b,x2);

title("dim = 13, iteration = 300");
legend("built-in","iterative");


subplot(1,2,2)
plot(b,e,b,x3);
title("dim = 13, iteration = 1000");
legend("built-in","iterative");




