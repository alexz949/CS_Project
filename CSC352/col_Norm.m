%Question 3
function x = col_Norm(A)
    num1 = size(A, 2);
    x = zeros(num1, 1);
    num2 = intmin;
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
