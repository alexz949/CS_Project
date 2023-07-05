function [X,L,M,R,LQ,MQ,LA,MA,Q,V] = hhqr_quasi_orth(F,B,Z)
%  F: cell array of factors of coefficient KR prod
%  B: cell array of factors on RHS
%  Z: weights of RHS
%  L: weights of E basis of householder vectors
%  M: weights of F basis of householder vectors
%  s: sign vector for E basis 


d = length(F);
n = size(F{1},2);

A = khatrirao(F);
K = khatrirao(F);
B_hat = khatrirao(B);

V = zeros(size(A,1),size(A,2));
expR = zeros(n);



E = zeros(size(A,1),n);
for i = 1:n
    E(i,i) = 1;
end
Etrue = zeros(size(A,1),n);
for i = 1:n
    Etrue(i,i) = 1;
end

% compute Householder QR


% Hadamard of Grams
G = F{1}'*F{1};
for i = 2:d
    G = G.*(F{i}'*F{i});
end

% cross products with E 
% (last matrix is identity, all others have 1s in 1st row only)
H = F{d}(1:n,1:n);
for i = 1:d-1
    H = H.*(ones(n,1)*F{i}(1,:));
end
noise = 1* 10^(-9);



LA = zeros(n); %Lambda weights of input
MA = eye(n);   %Mu weights of input
L = zeros(n);  %Lambda weights of householder vectors
M = zeros(n);  %Mu weights of householder vectors
R = zeros(n);  %upper trig factor


for k = 1:n
    %disp(k);
    e = E(:,k);
    ek = zeros(n,1); ek(k) = 1;
    x = A(:,k);
    
    
    %diagonal entry
    R(k,k) = sqrt(mynorm_sq(LA(:,k),MA(:,k),H,G));
    expR(k,k) = norm(x);
    %R(k,k) = expR(k,k);
    %diff = norm(A(:,k)) - sqrt(mynorm_sq(LA(:,k),MA(:,k),H,G));



    p = norm(x);
    
    E(:,k) = e;
    v = p * e-x;
    u = norm(v);
    %zero column
    if u == 0
        v = e;
    else
        v = v / u;
    end

     V(:,k) = v;
     J = (k+1:n);
     A(:,J) = A(:,J) - 2*v*(v'*A(:,J));

    


    
    %reflection
    L(:,k) = -LA(:,k);
    M(:,k) = -MA(:,k);
    L(k,k) = L(k,k) + R(k,k);
    
    
    sigma = mynorm_sq(L(:,k),M(:,k),H,G);
    if sigma <= 0
        L(:,k) = zeros(n,1);
        L(k,k) = 1;
        M(:,k) = zeros(n,1);
    else
        L(:,k) = L(:,k) / sqrt(sigma);
        M(:,k) = M(:,k) / sqrt(sigma);
    end

    impV = K * M(:,k) + E * L(:,k);
    normV = norm(V(:,k) - impV) / norm(V(:,k))

   
   

    r = e'* A(:,k+1:n);

    expR(k,J) = r;
   
    % update trailing matrix
    
    z = myprod(L(:,k),M(:,k),LA(:,k+1:n),MA(:,k+1:n),H,G);
    v'*A(:,J);
    diff_z = norm(z - v'*A(:,J)) / norm(z);
    
   

    
    %diff_v = norm(V(:,k) - impV) / norm(V(:,k)) 

    
   
    
    LA(:,k+1:n) = LA(:,k+1:n) - 2*L(:,k)*z;
    MA(:,k+1:n) = MA(:,k+1:n) - 2*M(:,k)*z; 
    impA = K * MA + E * LA;
    normA = norm(A - impA)/ norm(A)

    

    A(:,J) = A(:,J) - e* r;
    
    % set row of R
    
    R(k,k+1:n) = myprod(ek,zeros(n,1),LA(:,k+1:n),MA(:,k+1:n),H,G);
    %R(k,k+1:n) = expR(k,k+1:n);
    
    
   
    % update trailing matrix again
    LA(:,k+1:n) = LA(:,k+1:n) - ek * R(k,k+1:n);
    

     
    

end


  

% form Q
LQ = eye(n);
MQ = zeros(n);


expQ = E;
for k = n:-1:1
    z = myprod(L(:,k),M(:,k),LQ(:,k:n),MQ(:,k:n),H,G);
    
    LQ(:,k:n) = LQ(:,k:n) - 2*L(:,k)*z;
    MQ(:,k:n) = MQ(:,k:n) - 2*M(:,k)*z;
    v = V(:,k);
    expQ(:,k:n) = expQ(:,k:n) - 2 * v * (v' * expQ(:,k:n)); 
end

% Vtrue = K * M + Etrue * L;
% norm_Vtrue = norm(Vtrue- V)/ norm(V)





% form Q explicitly
K = khatrirao(F);

Q = K * MQ + E * LQ; 


% solve LS problem

% precompute cross products with F
C = F{1}'*B{1};
for k=2:length(B)
    C = C .* (F{k}'*B{k});
end

% cross products with E 
% (last matrix is identity, all others have 1s in 1st row only)
D = B{d}(1:n,:);
for i = 1:d-1
    D = D .* (ones(n,1)*B{i}(1,:));
end


% compute Q'*B*Z
%QtB = (MQ' * C + LQ' * D) * Z';

% computer Q'*B*Z through householder vectors
s = size(D,2);
N = eye(size(D,2));
LB = zeros(n,s);
MB = zeros(n,s);


for k = 1:n
    z_rhs = myprod_rhs(M(:,k),L(:,k),N,MB,LB,H,G,C,D);
    
    LB = LB - 2 * L(:,k)* z_rhs;
    MB = MB - 2 * M(:,k)* z_rhs; 
end




%compute

NZ = N * Z';
MBZ = MB * Z';
LBZ = LB * Z';



%householder transformation
QtB = myprod_rhs(zeros(n),eye(n),NZ,MBZ,LBZ,H,G,C,D);

%implicit forming
QtB2 = (MQ' * C + LQ' * D) * Z';

%explicit forming
expQtB = Q' * B_hat * Z';







% compute X via triangular solve and transpose
X = (R \ QtB)';


end
% 

function d = mynorm_sq(lambda,mu,H,G)
    d = myprod(lambda,mu,lambda,mu,H,G);
end


function C = myprod(lambda1,mu1,lambda2,mu2,H,G)
    C = lambda1'*lambda2 + lambda1'*H*mu2 + ...
        mu1'*H'*lambda2 + mu1'*G*mu2;
end

function T = exp(lambda, mu, E1,E2,F1,F2)
    T = khatrirao(E1,E2) * lambda + khatrirao(F1,F2) * mu;
end

function c = myprod_rhs(mu1,lambda1,nu1,mu2,lambda2,H,G,C,D)
    c = mu1' * C * nu1 + mu1' * G * mu2 + mu1' * H' * lambda2 + ...
        lambda1' * D * nu1 + lambda1' * H * mu2 + lambda1' * lambda2;
end