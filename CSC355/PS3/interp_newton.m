function c = interp_newton(x,y)
    
    n = size(x,2);
    c = zeros(n);
    for i = 1:n
        c(i,1) = y(i);
    end
    c
    

    for i = 2:n
        for j = 2:i
            
            c(i,j) = (c(i,j-1)-c(i-1,j-1)) ./ (x(i)- x(i-j+1));
        c;    
        end
        
    end
    c = diag(c);
end