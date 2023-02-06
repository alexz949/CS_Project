

function f_n = recFib(n)
    num1 = 0;
    num2 = 1;
    for a = 2:n
        f_n = num1 + num2;
        num1 = num2;
        num2 = f_n;
        fprintf("The number will be %f \n", f_n/num1)
        
    end
end





