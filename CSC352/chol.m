function L = chol(A)
    n = size(A);
    if n == 1
        L = sqrt(A);
    else
        L(1,1) = sqrt(A(1,1));
        L(2:n,1) = A(2:n, 1)/L(1,1);
        L(2:n,2:n) = (A(2:n,2:n) - L(2:n,1)* L(2:n,1)');
    end
end