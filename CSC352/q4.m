function x =  q4(A,d)
    n = size(A,1);

    x = zeros(n,1);
    for i = 2:n
        l = A(i,i-1)/ A(i-1,i-1);
        A(i,i) = A(i,i) - l * A(i-1,i);
        d(i) = d(i) - l * d(i-1);
    end

    x(n) = d(n)/ A(n,n);
    for j = n-1:-1:1
        x(j) = (d(j) - A(j,j+1)*x(j+1))/A(j,j); 
    end
end