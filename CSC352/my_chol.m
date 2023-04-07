function L = my_chol(A)
    n = size(A,1);
    if n == 1
        L = sqrt(A);
    else
        L(1,1) = sqrt(A(1,1));
        L(2:n,1) = A(2:n, 1)/L(1,1);
        L(2:n,2:n) = my_chol(A(2:n,2:n) - L(2:n,1)* L(2:n,1)');
    end
end