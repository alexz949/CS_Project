function p = my_fzero(f,df,x0)
    %p = my_fzero(f, df, x0) tried to find a zero of the function f near
    %x0, if x0 is a scalar. It first finds an interval containing x0 where
    %the function values of the interval endpoints differ in sign, then
    %search that interval for a zero. f is a function handle and df is the
    %function handle which is the first derivative of f. It will give out
    %an error message if it fails to find a valid interval. 
    %
    %It finds the interval using findinterval.m file. Once the interval is
    %found, it will apply newbis function to find the zero using either
    %newton's method or bisection method.
    
    %find interval process
    [a,b,iter] = findinterval(f,x0);

    %find zero
    p = newbis(f,df,a,b,iter);
    
    fprintf("Zero found in the interval [%3f,%3f]\n", a,b);

end