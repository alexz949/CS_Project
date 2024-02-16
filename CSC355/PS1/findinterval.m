function [a,b,count] = findinterval(f,x0)
    %[a,b] = findinterval(f,x0) tries to find an interval [a,b] around x0
    %such that f(a) and f(b) have different signs. Input f is a function
    %handle and x0 is a scalar value. 
    %
    %It first finds an interval containing x0 where the function values of 
    %the interval endpoints differ in sign f is a function handle. The 
    %function will return the interval or it will give error on either x0 
    %or function value exceeds real number range.


    a = x0;
    b = x0;
    dx = 0.001;
    count = 1;
    
    fprintf("Search for an interval around %.2f containing a sign change:\n", x0);
   
    disp(' Iter          a          f(a)          b           f(b)         Procedure');
    
    fprintf('%5.0f   %12.6g %12.6g %12.6g %12.6g        %s\n', count, a, f(a),b, f(b), "initial");
    % Break until signs are different 
    while (f(a) > 0) == (f(b) > 0)
        
        a = a - dx;
        %check whether f(a) or a is still in range
        if abs(f(a)) >= realmax || abs(a) >= realmax
            
            assert(0,"Failed to find an interval by reaching possible maximum real number");
            
        end
        
        b = b + dx;
        %check whether f(b) or b is still in range
        if abs(f(b)) >= realmax || abs(b) >= realmax
            
            assert(0,"Failed to find an interval by reaching possible maximum real number");
            
        end

        
        dx = 2 * dx;
        count = count + 1;
        fprintf('%5.0f   %12.6g %12.6g %12.6g %12.6g        %s\n', count, a, f(a),b, f(b), "search");
       
        
    end
    
   

    


end