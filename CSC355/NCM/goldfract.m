function goldfract(n) 
%GOLDFRACT Goldenratiocontinuedfraction. 
% GOLDFRACT(n)displays nterms. 
p= '1'; fork=1:n p=['1+1/(’p’)’]; end p p=1; q=1; fork=1:n s=p; p=p+q; q=s;1.1. TheGoldenRatio 7 end p=sprintf(’%d/%d’,p,q) formatlong p=eval(p) formatshort err=(1+sqrt(5))/2-p