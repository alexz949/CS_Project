function p = newbis(f, df, a, b, iter)
    %p = newbis(f, df, a, b) tries to find a zero in the interval [a,b].
    %Input f is a function handle. Input df is the first derivative of
    %input f. a and b are the interval value.
    %
    %It first compute the newton's update function based on f and df. Then
    %it will update the interval using newton's method. If the point is
    %outside of interval [a,b], it will try to use bisection method. This
    %function will terminate when the output is smaller than 100*eps.
    
    %init
    p = a;
    tol = 100 * eps;
    count = iter;
    check = 0;
    fprintf("Search for a zero in the interval [%.3f,%.3f]\n", a, b);
    disp(' Iter        x          f(x)             Procedure');
    
    fprintf('%5.0f   %13.6g %13.6g        %s\n', count, p, f(p), "initial");
    
    
    while(abs(f(p)) > tol)

        %newton's step:
        p = p - f(p)/ df(p);
        
        %bisection method
        if p < a || p > b
            check = 1;
            p = (a+b)/2;
        end
        %update p value
        if(f(p)*f(b) < 0)
            a = p;
        else
            b = p;
        end
       
        count = count +1;

        %print the number of iter, function value and what method it used
        if(check == 1 )
            fprintf('%5.0f   %13.6g %13.6g        %s\n', count, p, f(p), "bisection");
        else
            fprintf('%5.0f   %13.6g %13.6g        %s\n', count, p, f(p), "newton");
        end
        check = 0;
    end
    
end