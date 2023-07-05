tic
 
 B =hess(A);
n = size(A,1);
%%%%%%%%%%%%%
for k = 1:1000
    for j = 1:899
        c = B(j,j);
        s = B(j+1,j);
        G = [c,-s;s,c];
        B(j:j+1,j:n) = G' * B(j:j+1,:);
    end
    Q = eye(n);
    for j = 1:899
        B(1:j+1,j:j+1)= B(1:j+1,j:j+1) * G;
        Q(1:j+1,j:j+1)= Q(1:j+1,j:j+1) * G;
    end
    

end
toc



x3 = [];
for i = 1:900
    x3 = [x3, B(i,i)];
end
b = [];
for i = 1:900
    b = [b,i];
end
x3 = sort(x3);