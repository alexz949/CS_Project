A = randn(3,3);
B = randn(3,3);
C = randn(3,3);
E = randn(3,3);
F = cell(5,1);
F{1} = A;
F{2} = B;
F{3} = C;
F{4} = E;

%QR for each factor matrix
[Q,Q_hat,R,testR] = kr_qr(F);
Q

%do kron Q
% S =Q{1};
% 
% S  = kron(S,Q{2});
% S  = kron(S,Q{3});
% S  = kron(S,Q{5});
% t = S;
S =Q{1};
for i = 2:5
    if ~isempty(Q{i})
        S = kron(S,Q{i});
    end
end
% normT = norm(t - S)/ norm(t)


testF =S * testR ;
norm(S' * S)
j = 0;
for i = 1:5
    if isempty(F{i})
        j = i;
    end
end

krpF  = khatrirao(F{[1:j-1,j+1:5]});
size(krpF);
[expQ,expR] = qr(krpF,0);



normF = norm(testF - krpF) / norm(krpF);
%Qtb 
X = cell(4,1);
X{1} = F{1};
X{2} = F{2};
X{3} = F{3};
X{4} = F{4};

D = apply_kr_qr(Q,Q_hat,X,eye(3,3),5);

% testQ = cell(5-1,1);
% j = 1;
% for i = 1:5
%     if ~isempty(X{i})
%         if ~isempty(Q{i})
%         testQ{i} = Q{j}' * X{i};
%         j = j+1;
%         end
%     end
%     
% end
% 
% check = khatrirao(testQ,'r');




%exp Qtb
Ft = khatrirao(A,B,C, 'r');
[Qt,Rt] = qr(Ft,0);
Qtb = Qt' * Ft * eye(3,3)';



%I think if everything is true this should give out an identity matrix
unit_test = (R \ D)