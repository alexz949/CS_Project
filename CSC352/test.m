tic 
A = rand(12000,4400);
B = rand(12000,4400);
C = A' * B;
D = C' * C;
E = A * B';
for i = 1:5000
    F = C + D;
end
toc
