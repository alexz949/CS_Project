function D = apply_kr_qr(Q,Q_hat,B,C,n)
%  Q: cell array of factors QR's Q full size
%  Q_hat: cell array of pairwise Q skip size
%  B: cell array of factors on RHS skip size
%  C: RHS transpose
%  D: QtB


%RHS skip

d = length(Q);
Qn = cell(d-1,1);

% shrink factor matices Q
j = 1;
for i =  1:d
    if  i ~= n
        Qn{j} = Q{i};
        
        j = j+1;
    end
end





for i = 1:d-1
    B{i} = Qn{i}' * B{i};
   
end


%checked that Q' on RHS is accurate
qtb_KRP = khatrirao(B, 'r');



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
    
        B{i-1} = khatrirao(B{i}, B{i-1}); 
%         test
%         Q_t
        B{i-1} = Q_t{i-1}' * B{i-1};
        j = j + 1;
end


D = B{1};
size(D);

D = D * C';


end