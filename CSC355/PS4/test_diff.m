fx = @(x) 1 ./ (1+exp(1).^x + 25*x.^2);

h = 0.2;
X = -1:h:1;
f = fx(X);

d1 = zeros(1,2/h);
% forward difference
for i = 1:2/h
   d1(i) = (f(i+1) - f(i))/h;
end
d1

st = diff(f)/h

% central difference
cd1 = zeros(1,2/h+1);
cd1(1)  = (f(2) - f(1))/h; 
cd1(2/h+1) = (f(2/h+1) - f(2/h))/h;
for i = 2:2/h
    cd1(i)  = (f(i+1)-f(i-1))/ (2*h);
    
end
cd1
col = gradient(f,h)
