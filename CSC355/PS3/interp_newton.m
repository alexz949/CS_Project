function c = interp_newton(x,y)
    %INTERP_NEWTON interpolates polynomial based on points using newton's
    %   basis. c = interp_newton(x,y) finds the coefficients of a polynomial 
    %   of degree based on the number of input points. c is a row vector
    %   containing all coefficients in newton basis in ascending powers. x
    %   and y are row vectors. Function computes the divided differences 
    %   and treats these as coefficients.
    n = size(x,2);
    c = zeros(n);
    
    assert(length(x) == length(y),"Dimension for x and y does not match");
    
    %base case
    for i = 1:n
        c(i,1) = y(i);
    end
    %inductive case
    for i = 2:n
        for j = 2:i
            c(i,j) = (c(i,j-1)-c(i-1,j-1)) ./ (x(i)- x(i-j+1)); 
        end
    end
    c = diag(c)';
end