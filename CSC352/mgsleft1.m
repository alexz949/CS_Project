function [Q,R] = mgsleft1(A)
% BLAS-1 version of left-looking modified Gram Schmidt

    [m,n] = size(A);
    assert(m >= n);
    
    Q = A;
    R = zeros(n,n);
    
    for j = 1:n
        for i = 1:j-1
            R(i,j) = Q(:,i)' * Q(:,j);
            Q(:,j) = Q(:,j) - Q(:,i) * R(i,j);
        end
        R(j,j) = norm(Q(:,j));
        Q(:,j) = Q(:,j) / R(j,j);
    end

end