function [X,Q,R] = hhqr_quasi_ls(F,B,Z)
%  F: cell array of factors of coefficient KR prod
%  B: cell array of factors on RHS
%  Z: weights of RHS

d = length(F);
n = size(F{1},2);

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

%s  = zeros(1,n);
FEwts = zeros(n);
FFwts = eye(n);
VEwts = zeros(n);
VFwts = zeros(n);
R = zeros(n);
s = ones(n,1);
for k = 1:n
    % rho = norm(Ak)
    R(k,k) = mynorm(FEwts(:,k),FFwts(:,k),H,G);  
    % compute sign(Ek'*Ak)
    ek = zeros(n,1); ek(k) = 1;
    %s(k) = sign(myprod(ek,zeros(n,1),FEwts(:,k),FFwts(:,k),H,G));
    % compute v = rho*e - x
    VEwts(k,k) = R(k,k);
    VFwts(k,k) = -1;
    % compute v = v - E(:,1:k-1)(E(:,1:k-1)'*v)
    z = myprod([eye(k-1); zeros(n-k+1,k-1)],zeros(n,k-1),VEwts(:,k),VFwts(:,k),H,G);
    VEwts(1:k-1,k) = VEwts(1:k-1,k) - z;
    % v = v / norm(v)
    sigma = mynorm(VEwts(:,k),VFwts(:,k),H,G);
    VEwts(:,k) = VEwts(:,k) / sigma;
    VFwts(:,k) = VFwts(:,k) / sigma;
    v{k} = khatrirao(F,'r')*VFwts(:,k);
    v{k}(1:n) = v{k}(1:n)+VEwts(:,k);
    % update trailing matrix
    z = myprod(VEwts(:,k),VFwts(:,k),FEwts(:,k+1:n),FFwts(:,k+1:n),H,G);
    FEwts(:,k+1:n) = FEwts(:,k+1:n) - 2*VEwts(:,k)*z;
    FFwts(:,k+1:n) = FFwts(:,k+1:n) - 2*VFwts(:,k)*z;
    % set row of R
    %ek = zeros(n,1); ek(k) = 1;
    R(k,k+1:n) = s(k)*myprod(ek,zeros(n,1),FEwts(:,k+1:n),FFwts(:,k+1:n),H,G);
    % update trailing matrix again
    FEwts(k,k+1:n) = FEwts(k,k+1:n) - R(k,k+1:n);
end

% form Q
QEwts = diag(s);
QFwts = zeros(n);
for k = n:-1:1
    z = myprod(VEwts(:,k),VFwts(:,k),QEwts(:,k:n),QFwts(:,k:n),H,G);
    QEwts(:,k:n) = QEwts(:,k:n) - 2*VEwts(:,k)*z;
    QFwts(:,k:n) = QFwts(:,k:n) - 2*VFwts(:,k)*z;
end



% form Q explicitly
Q = khatrirao(F,'r')*QFwts;
Q(1:n,:) = Q(1:n,:) + QEwts;

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
QtB = (QEwts'*D + QFwts'*C) * Z';

% compute X via triangular solve and transpose
X = (R \ QtB)';

m = size(v{1},1);
size(v{1})
fullQ = (eye(m) - 2*v{1}*v{1}') * (eye(m) - 2*v{2}*v{2}') * (eye(m) - 2*v{3}*v{3}');
fullQ(:,1:n)
end

function d = mynorm(lambda,mu,H,G)
    d = sqrt(myprod(lambda,mu,lambda,mu,H,G));
end

function C = myprod(lambda1,mu1,lambda2,mu2,H,G)
    C = lambda1'*lambda2 + lambda1'*H*mu2 + ...
        mu1'*H'*lambda2 + mu1'*G*mu2;
end