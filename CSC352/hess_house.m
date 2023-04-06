
function H = hess_house(A)
    n = max(size(A));
   
    H=A;
    for k = 1:(n-2)
        x = H(k+1:n, k);
        E = eye(n-k);

        if(x(1,1) >= 0)
            u = x + norm(x) * E(:,1);
        else
            u = x - norm(x) * E(:,1);
        end
        u = u / norm(u);
        H(k+1:n,k:n)= H(k+1:n,k:n) - 2*u*(u'*H(k+1:n,k:n)); 
        H(1:n,k+1:n)=H(1:n,k+1:n) - 2 *(H(1:n,k+1:n) * u) * u';

       
    end
end











