f =@(x) 1 ./ (1+ exp(1).^x + 25* x.^2);
n = [7, 9, 11 13, 15];

x_int = linspace(-1,1,7);
p_int = polyfit(x_int, f(x_int) , 6);

p_int


