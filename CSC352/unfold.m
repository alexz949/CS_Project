 function X = unfold(A,n)
    d = size(A);
    X = reshape(shiftdim(d,n-1), d(n), []);
 end