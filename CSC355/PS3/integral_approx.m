%integral_approx will produce two chunks of printing statements. The first
%one is number of points and their integral values using global
%interpolation. The second chunk is the information using piecewise cubic
%interpolation.
f =@(x) 1 ./ (1+ exp(1).^x + 25* x.^2);
n = [7, 9, 11 13, 15];
% Integral for global interpolation
fprintf("Single interpolating polynomial:\n")
fprintf("-------------------------------------\n")
fprintf("Points %20s\n", "Integral value")

for j = 1:size(n,2)
    x_int = linspace(-1,1,n(j));
    p_int = polyfit(x_int, f(x_int) , n(j)-1);
    upSum = 0;
    lowSum = 0;
    count = n(j);
    % Upper bound
    for i = 1:n(j)
        upSum = upSum + p_int(i)/count;
        count = count - 1;
    end
    %Lower Bound
    count = n(j);
    for i = 1:n(j)
        lowSum = lowSum + p_int(i) * (-1)^count/count;
        count = count - 1;
    end
    fprintf("%5d        %13.6f\n", n(j), upSum - lowSum);
end
fprintf("\n");

% Integral for piecewise cubic spline
fprintf("Piecewise cubic polynomial:\n")
fprintf("-------------------------------------\n")
fprintf("Points %20s\n", "Integral value")
for j = 1:size(n,2)
    xq = linspace(1,-1, n(j));
    pp = spline(xq,f(xq));
    Valsum = 0;
    %Loop for all piecewise integral at all n(j) points
    for k = 1:n(j)-1
        up_part = 0;
        low_part = 0;
        %coefs for polynomial
        a = pp.coefs(k,1);
        b = pp.coefs(k,2);
        c = pp.coefs(k,3);
        d = pp.coefs(k,4);
        x1 = pp.breaks(k);
        %integral function
        f_int = @(x)a*(x-x1).^4/4 + b*(x-x1).^3/3 + c*(x-x1).^2/2 + d*(x-x1);
        Valsum = Valsum + f_int(pp.breaks(k+1)) - f_int(pp.breaks(k));
    end
    fprintf("%5d        %13.6f\n", n(j), Valsum);
end








