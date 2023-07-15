function [D,qtb_KRP] = apply_kr_qr(Q,Q_hat,B,C)
%  Q: cell array of factors QR's Q 
%  Q_hat: cell array of pairwise Q
%  B: cell array of factors on RHS
%  C: RHS transpose
%  D: QtB



d = length(Q);
n = size(Q{1},2);
Qn = cell(d-1,1);
% shrink factor matices Q
j = 1;
for i =  1:d
    if ~isempty(Q{i})
        Qn{j} = Q{i};
        j = j+1;
    end
end
Qn;


%shrink RHS
test = cell(d-1,1);
j = 1;
for i = 1:d
    if ~isempty(B{i})
        test{j} = B{i};
        j = j+1;
    end
end

%do Q' B on RHS with shrinked array'
for i = 1:d-1
    test{i} = Qn{i}' * test{i};
   
end


%checked that Q' on RHS is accurate
qtb_KRP = khatrirao(test, 'r');



%shrink Q_hat
Q_t  =cell(d-2,1);
j = 1;
for i  = 1:d-1
    if ~isempty(Q_hat{i})
        Q_t{j} = Q_hat{i};
        j = j+1;
    end
end





%update pairwise
j = 1;
for i = d-1:-1:2
%     i
%     size(B{i})
%     size(B{i+1})
    
        test{i-1} = khatrirao(test{i}, test{i-1}); 
%         test
%         Q_t
        test{i-1} = Q_t{i-1}' * test{i-1};
        j = j + 1;
end


D = test{1};
size(D);

D = D * C';


end