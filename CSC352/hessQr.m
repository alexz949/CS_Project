tic
H = hess(A);
n = size(A,1);
%%%%%%%%%%%%%
for k = 1:1000
    %Hessenberg QR
   for j = 1:n-1
    c = H(j,j);
    s = H(j+1,j);
    G = [c,-s;s,c];
    H(j:j+1,j:n) =  G* H(j:j+1,j:n);
   end
   for j = 1:n-1
       H(1:j+1,j:j+1)=H(1:j+1,j:j+1)* G;
   end
end
toc



x3 = [];
for i = 1:900
    x3 = [x3, H(i,i)];
end
b = [];
for i = 1:900
    b = [b,i];
end
x3 = sort(x3);