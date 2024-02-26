f_spline =@(x) 1 ./ (1+ exp(1).^x + 25* x.^2);
 
n = [3,5,7,9];
xx = -1:0.01:1;
for i = 1:4
    xq = linspace(1,-1, n(i));
    pp = spline(xq,f_spline(xq));
    if i == 3
        disp(pp.coefs);
    end
    plot(xx, ppval(pp,xx)), hold on
end

    

    








