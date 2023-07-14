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
    if ~isempty(Q{i})
       if ~isempty(B{i})
           
            B{i} = Q{i}' * B{i};
            
       end
    end
end

Q_t  =cell(d-2,1);
j = 1;
for i  = 1:d-1
    if ~isempty(Q_hat{i})
        Q_t{j} = Q_hat{i};
        j = j+1;
    end
end




test = cell(d-1,1);
j = 1;
for i  = 1:d
    if ~isempty(B{i})
        test{j} = B{i};
        j = j+1;
    end
end


%update pairwise

for i = 1:d-2
%     i
%     size(B{i})
%     size(B{i+1})
    if ~isempty(test{i})
        test{i+1} = khatrirao(test{i}, test{i+1}); 
    
        test{i+1} = Q_t{i}' * test{i+1};
        
    end
    
    
    

end

D = test{d-1};

D = D * C';


end