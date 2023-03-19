%(a)
A = [8,5,2;21,19,16;39,48,53];
b = [15;56;140];
x = A \ b;
disp(x);


%(b)
A_1 =  [8,5,2;21,19,16;39,48,53];
b_1 = [14;56;140];
x_1 = A_1 \ b_1;
disp(x_1);



%(c)
%I think it is ill-conditioned because I change one entry by subtracting
%one, my results vary from an absolute value about 200 to 400.



%(d)
k = cond(A);
disp(k)
%The value of condition number is about 6.5e+04, which is large.