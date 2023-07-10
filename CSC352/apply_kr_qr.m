function D = apply_kr_qr(Q,Q_hat,B,C)
%  Q: cell array of factors QR's Q 
%  Q_hat: cell array of pairwise Q
%  B: cell array of factors on RHS
%  C: RHS transpose
%  D: QtB
d = length(Q);
n = size(Q{1},2);

%update RHS with Q'
for i = 1:d
    B{i} = Q{i}' * B{i};
end



test = cell(d-1,1);

%update pairwise
for i = 1:d-1
    B{i+1} = khatrirao(B{i}, B{i+1});
    
    B{i+1} = Q_hat{i}' * B{i+1};
    

end

D = B{d};
D = D * C';


end