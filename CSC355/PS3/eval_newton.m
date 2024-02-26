function yq = eval_newton(c, x, xq)
    n = size(c,1);
    m = size(xq,2);
    yq = zeros(m,1);
    
    for i = 1:m
        yq(i) = c(1);
        w = (xq(i) - x(1));
        for j = 2:n
            yq(i) = yq(i) + c(j) * w;
            w = w * (xq(i) - x(j));
            
        end
    end
    
    
end