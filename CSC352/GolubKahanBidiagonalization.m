function [U, B, V] = GolubKahanBidiagonalization(A)
    [m, n] = size(A);
    U = eye(m); % Initialize U as identity matrix
    V = eye(n); % Initialize V as identity matrix
    b = A(:, 1); % Initialize first column of bidiagonal matrix B
    beta = norm(b); % Compute norm of first column
   
        for j = 1:n
            % Compute Householder reflection for current column
            x = A(j:m, j);
            vec = zeros(1, length(x));
            vec = vec';
            vec(1) = 1;
            v = x +  sign(x(1)) * norm(x) *vec;
            v = v / norm(v);
            % Apply Householder reflection to A and U
            A(j:m, j:n) = A(j:m, j:n) - 2 * (v * v') * A(j:m, j:n);
            U(j:m, :) = U(j:m, :) - 2 * v * (v' * U(j:m, :));
            if j < n-1
                % Compute Householder reflection for next row of A
                x = A(j, j+1:n);
                vec = zeros(1, length(x));
                vec = vec';
                vec(1) = 1;
                u =x +  sign(x(1)) * norm(x) * vec;
                u = u / norm(u);
                % Apply Householder reflection to A and V
                A(j:m, j+1:n) = A(j:m, j+1:n) - 2 * (A(j:m, j+1:n) * u) * u';
                V(:, j+1:n) = V(:, j+1:n) - 2 * (V(:, j+1:n) * u) * u';
            end
        end
        B = A;
    
    % Extract bidiagonal matrix B from A
    
end

