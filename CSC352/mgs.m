function [Q,R] = mgs(A)

    [m,n] = size(A); % number of columns of A
    
    R = zeros(n); % initialize Q,R matrices
    Q = zeros(m,n);

    for j = 1:n
        w = A(:,j); % initialize vector

        for i = 1:j-1
            R(i,j) = Q(:,i)'*w;  % this part is different from CGS

            w = w - R(i,j)*Q(:,i); 
        end
        R(j,j) = norm(w);
        Q(:,j) = w/R(j,j);  % normalize 
    end
end