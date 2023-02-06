function ans = expFib(x)
    ans = (1/sqrt(5)) * (((1+sqrt(5))/2)^x  - ((1-sqrt(5))/2)^x );

    fprintf("This time the number will be %f", ans)
end