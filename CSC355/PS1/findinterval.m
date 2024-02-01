function [a,b] = findinterval(f,x0)

    a = x0;
    b = x0;
    dx = 0.001;
    
    
    while (f(a) >= 0) == (f(b) >= 0)
        
        a = a - dx;
        if abs(f(a)) >= realmax || abs(a) >= realmax
            
            assert(0,"Failed to find an interval by reaching possible maximum real number");
            
        end
        
        b = b + dx;
        if abs(f(b)) >= realmax || abs(b) >= realmax
            
            assert(0,"Failed to find an interval by reaching possible maximum real number");
            
        end
        
        dx = 2 * dx;
        

       
        
    end
   

    


end