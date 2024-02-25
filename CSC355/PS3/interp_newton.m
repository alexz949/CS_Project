function c = interp_newton(x,y)
    
    n = size(x,2);
    c = zeros(n+1);
    for i = 1:n+1
        c(i,1) = y(i);
    end
    

    for i = 2:n
        for j = 2:i
            j
            c(i,j) = (c(i,j-1)-c(i-1,j-1)) ./ (x(i)- x(i-j+1));
        end
    end
    c = diag(c);
end