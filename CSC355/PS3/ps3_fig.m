%This script is used for generating my figure showed in Problem Set 3
%Problem 4
f_spline =@(x) 1 ./ (1+ exp(1).^x + 25* x.^2);
 
n = [3,5,7,9];
    
    xx = -1:0.01:1;
    figure,
    
    plot(xx, f_spline(xx), 'LineWidth',2), hold on
for i = 1:4
    xq = linspace(1,-1, n(i));
    pp = spline(xq,f_spline(xq));
    
    plot(xx, ppval(pp,xx),'LineWidth',2), hold on
    

    
   
end
    a = gca;
    a.FontSize = 16;
lgd = legend("Fun","n=3","n=5", "n=7", "n=9");
fontsize(lgd,16, 'points')

    








