T = tensor(rand(200,200,200));
A = randn(100,200);
B = randn(1000,200);
C = randn(1000,200);


tic
T = ttm(T,A,1);
T = ttm(T,B,2);

T = ttm(T,C,3);

toc




