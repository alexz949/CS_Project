function [fp,p] = bisection(f,a,b)
    maxiter = 1076;
    TOL = 100 *eps;
    fa = f(a);
    i = 1;
    while abs(f(a)) > TOL
        
        p =  a + (b-a) / 2;
        fp = f(p);
        

        
      
        if abs(b-a) / 2 <= TOL
           break;
        end

        
        
        if fa *  fp > 0
            a = p;
            fa = fp;
        else
            b = p;
        end
        
        i = i+1;
    end
    i
    
    if i >= maxiter
        fprintf("Method failed after N0 iterations, N0 = %d", maxiter);
    end
end