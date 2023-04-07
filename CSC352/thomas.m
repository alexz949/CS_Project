function x = thomas(A,y)
    n = length(y);

    x = zeros(n,1);
    for i = 2:n
        t = A(i,i-1)/A(i-1,i-1);
        A(i,i) = A(i,i) - t* A(i-1,i);
        y(i) = y(i) - t* y(i-1);
    end

    x(n) = y(n)/A(n,n);

    for j = n-1:-1:1
        x(j) = (y(j) - A(j,j+1)*x(j+1))/A(j,j);
    end

end