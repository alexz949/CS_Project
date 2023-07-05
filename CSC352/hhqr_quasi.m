function [L,M,R,LQ,MQ,LA,MA,Q] = hhqr_quasi(F)
%  F: cell array of factors of coefficient KR prod
%  L: weights of E basis of householder vectors
%  M: weights of F basis of householder vectors
%  s: sign vector for E basis 


d = length(F);
n = size(F{1},2);
E1 = zeros(size(F{1},1),n);
E1(1,:) = 1;
E2 = eye(size(F{2},1),n);


K = khatrirao(F);
kt = size(K,1);
kt2 = size(K,2);
Etrue = zeros(kt,kt2);
for i = 1: kt2
    Etrue(i,i) = 1;
end

% compute Householder QR

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
ei = eye(n);
ez = zeros(n);

%s  = zeros(1,n);

LA = zeros(n); %Lambda weights of input
MA = eye(n);   %Mu weights of input
L = zeros(n);  %Lambda weights of householder vectors
M = zeros(n);  %Mu weights of householder vectors
R = zeros(n);  %upper trig factor
s = ones(n,1); %sign vector
%[qt,rt] = householder_trig(khatrirao(F{1},F{2}));
%C = qt * rt;
ek = zeros(n,1);


for k = 1:n
    %disp(k);
    ek = zeros(n,1); ek(k) = 1;
    et = zeros(n,1);
    eim = zeros(n,k-1);
    for i = 1: k-1
        eim(i,i) = 1;
    end
    R(k,k) = mynorm(LA(:,k),MA(:,k),H,G);
    %disp(R(k,k));
    
    L(:,k) = -LA(:,k);
    M(:,k) = -MA(:,k);

    L(k,k) = L(k,k) + R(k,k);
    
   
    
    sigma = mynorm(L(:,k),M(:,k),H,G);
    L(:,k) = L(:,k) / sigma;
    M(:,k) = M(:,k) / sigma;

    V = K * M + khatrirao(Etrue) * L
    
    
    
   

    % update trailing matrix
    z = myprod(L(:,k),M(:,k),LA(:,k+1:n),MA(:,k+1:n),H,G);
    
    LA(:,k+1:n) = LA(:,k+1:n) - 2*L(:,k)*z;
    MA(:,k+1:n) = MA(:,k+1:n) - 2*M(:,k)*z;

    % set row of R
    
    R(k,k+1:n) = myprod(ek,et,LA(:,k+1:n),MA(:,k+1:n),H,G);
    
   
    % update trailing matrix again
    LA(:,k+1:n) = LA(:,k+1:n) - ek * R(k,k+1:n);

    out2 = exp(LA(:,k+1:n),MA(:,k+1:n),E1,E2,F{1},F{2});
end
  



 
% form Q
LQ = diag(s);
MQ = zeros(n);

for k = n:-1:1
    z = myprod(L(:,k),M(:,k),LQ(:,k:n),MQ(:,k:n),H,G);
    LQ(:,k:n) = LQ(:,k:n) - 2*L(:,k)*z;
    MQ(:,k:n) = MQ(:,k:n) - 2*M(:,k)*z;
end
Q = exp(LQ,MQ, E1,E2,F{1},F{2});


Q = K * MQ + khatrirao(Etrue) * LQ;



H1 = eye(kt) - 2 * V(:,1) * V(:,1)';
H2 = eye(kt) - 2 * V(:,2) * V(:,2)';
H3 = eye(kt) - 2 * V(:,3) * V(:,3)';
testQ = H3 * H2 * H1;
testQ = testQ' * eye(kt,kt2);
end


% form Q explicitly
%Q = khatrirao(F,'r')*QFwts;
%Q(1:n,:) = Q(1:n,:) + QEwts;






function d = mynorm(lambda,mu,H,G)
    d = sqrt(myprod(lambda,mu,lambda,mu,H,G));
end

function C = myprod(lambda1,mu1,lambda2,mu2,H,G)
    C = lambda1'*lambda2 + lambda1'*H*mu2 + ...
        mu1'*H'*lambda2 + mu1'*G*mu2;
end

function T = exp(lambda, mu, E1,E2,F1,F2)
    T = khatrirao(E1,E2) * lambda + khatrirao(F1,F2) * mu;
end