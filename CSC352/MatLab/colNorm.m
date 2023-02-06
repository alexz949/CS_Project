

function x = colNorm(A)
    A = [-2,5,0,-1;1,6,8,-4;-4,0,2,0;-3,1,1,-6];
    num1 = size(A, 2);
    x = zeros(num1, 1);
    num2 = -100000;
    i = 1;
    for a = 1:size(A,2)
        
       for b = 1:size(A,1)
           num2 = max(num2,abs(A(b,a)));

           
       end
       

       x(i) = num2;
       i = i+1;
       num2 = 0;
       
    end




end
