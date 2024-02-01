f_test = @(x) x^3-x;



x0 =-1.4e+105;

%failure
[af,bf] = findinterval(f_test,x0);
af
bf



