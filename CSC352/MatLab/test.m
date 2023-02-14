A = zeros(800,800);
B = zeros(800,800);
for i = 1:800
    for j = 1:800
        A(i,j) = i*j;
        B(i,j) = i*j;
    end
end
tic 
C = A*B;
toc