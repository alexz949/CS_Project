e = eig(A);
B = C;
%create hessenberg form of the matrix


%%
for k = 1:10
    [Q,R] = qr(B);
    B = R* Q;
end



x = [];
for i = 1:len
    x = [x, B(i,i)];
end
b = [];
for i = 1:len
    b = [b,i];
end
x = sort(x);
e = e';
sum = 0;

%%



%%%%%%%%%%%%%
for k = 1:100
    [Q,R] = qr(B);
    B = R* Q;
end



x1 = [];
for i = 1:len
    x1 = [x1, B(i,i)];
end
b = [];
for i = 1:len
    b = [b,i];
end
x1 = sort(x1);
%%
sum = 0;
for i = 1:len
    sum = sum + (x4(i)-e(i))*(x4(i)-e(i));
end
disp(sum);
%%


%%%%%%%%%%%%%
for k = 1:300
    [Q,R] = qr(B);
    B = R* Q;
end



x2 = [];
for i = 1:len
    x2 = [x2, B(i,i)];
end
b = [];
for i = 1:len
    b = [b,i];
end
x2 = sort(x2);

%%
tic
B = A;
 
n = size(A,1);
%%%%%%%%%%%%%
for k = 1:1000
    %built-in QR
    
    [Q,R] = qr(B);
    B = R* Q;
end
toc



x3 = [];
for i = 1:900
    x3 = [x3, B(i,i)];
end
b = [];
for i = 1:900
    b = [b,i];
end
x3 = sort(x3);




%%
%%%%%%%%%%%%%
for k = 1:2000
    [Q,R] = qr(B);
    B = R* Q;
end
toc




x4 = [];
for i = 1:len
    x4 = [x4, B(i,i)];
end
b = [];
for i = 1:len
    b = [b,i];
end
x4 = sort(x4);




figure
subplot(1,2,1)
plot(b,e,b,x)
title("dim = 900, iteration = 10")
legend("built-in","iterative");



subplot(1,2,2)
plot(b,e,b,x1);
title("dim = 900, iteration = 100");
legend("built-in","iterative");

figure
subplot(1,2,1)
plot(b,e,b,x2);

title("dim = 900, iteration = 300");
legend("built-in","iterative");


subplot(1,2,2)
plot(b,e,b,x3);
title("dim = 900, iteration = 1000");
legend("built-in","iterative");


figure
plot(b,e,b, x4)
title("dim = 900, iteration = 2000");
legend("built-in","iterative");







