function yq = eval_newton(c, x, xq)
    %EVAL_NEWTON evaluates polynomial based on divided differences.
    %   yq = eval_newton(c, x, xq) returns yq as a row vector which
    %   includes the value of polynomial c evaluated at xq. c is a row 
    %   vector with all coefficients of a newton basis polynomial in 
    %   ascending power. xq is a row vector with evaluation points.

    n = size(c,2);
    m = size(xq,2);
    yq = zeros(1,m);
    assert(length(c) == length(x), "Degree for c and x does not match");
    
    for i = 1:m
        yq(i) = c(1);
        w = (xq(i) - x(1));
        %Leave intercept out and compute the rest.
        for j = 2:n
            yq(i) = yq(i) + c(j) * w;
            w = w * (xq(i) - x(j));
        end
    end
end