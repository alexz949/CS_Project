f_test = @(x) x^3-x;


%point that success
fprintf("Successeful one:\n")
x0 = 0.577;

[a,b] = findinterval(f_test,x0);
a
b


fprintf("Unsuccessful one:\n")
%point that fails
x0 =-1.4e+105;


[af,bf] = findinterval(f_test,x0);
af
bf



