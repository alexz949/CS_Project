function [Q,R] = mgs(A)
    [n,m] = size(A);
    Q = zeros(n,m); %initialize matrices
    R = zeros(m,m);
    for j = 1:m
        x = A(:,1);
        for i = 1:j-1
            R(i,j) = Q(:,i)'* x;
            x = x - R(i,j) * Q(:,i);
        end
        R(j,j) = norm(x)';
        Q(:,j) = x / R(j,j);
    end
    %show error
    disp(norm(A-Q*R));
end