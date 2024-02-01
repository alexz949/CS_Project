function [fp,p] = bisection(f,a,b)
    maxiter = 1076;
    TOL = 10^-14;
    fa = f(a);
    i = 1;
    while i < maxiter
        
        p =  a + (b-a) / 2;
        fp = f(p);
        

        if abs(fp) < TOL
            break;
        end
      
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