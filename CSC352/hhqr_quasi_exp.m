function [X,Q,R,V] = hhqr_quasi_exp(F,B,Z)
%size
%[E,r] = qr(A,0);
A = khatrirao(F);
B_hat = khatrirao(B);

V = zeros(size(A,1),size(A,2));

n = size(A,2);

E = zeros(size(A,1),n);
for i = 1:n
    E(i,i) = 1;
end


R = zeros(n);


for k = 1:n %trig
    e = E(:,k);
    x = A(:,k);

    p = norm(x);
    R(k,k) = norm(x);
    a =e' * x;
    
    %outA1 = A(:,k)
%     %check sign
%     if a == 0
%         s = 1;
%     else 
%         s = -a/norm(a);
%     end
    %imporve orthogonality
    %e = s*e;
    
    E(:,k) = e;
    v = p * e-x;
    %v = v - E(:,1:k-1)*(E(:,1:k-1)' * v);
    u = norm(v);
    %zero column
    if u == 0
        v = e;
    else
        v = v / u;
    end

    %reflection
    

    
    V(:,k) = v;
    
    J = (k+1:n);
    
    A(:,J) = A(:,J) - 2*v*(v'*A(:,J));
    
    
    
    r = e'* A(:,k+1:n);
    
    R(k,J) = r;
    A(:,J) = A(:,J) - e* r;
    
    
    
end


Q = E;

%Q formation 
for k = n:-1:1
    v = V(:,k);
    J = (k:n);
    Q(:,k:n) = Q(:,k:n) - 2*v*(v' * Q(:,k:n));
end

QtB = Q' * B_hat * Z';

size(QtB)
X = (R \ QtB)';



end




