fprintf("Approximating the golden ratio...\n");


r0 = 0;
r1 = 1;

i = 0;


while abs(r1-r0) > 10^(-15)
    f0 = expFib(i);
    f1 = expFib(i+1);
    f2 = expFib(i+2);

    r1 = f2 ./ f1;
    r0 = f1 ./ f0;
    i = i+1;
    
end



fprintf("...required the %dth Fibonacci number\n", i+1);
fprintf("\n");
fprintf("Golden ratio is approximately %.16f\n", f2./f1);
fprintf("Last change in approximation was %.1e\n", abs(r1-r0));
fprintf("Computed using ratio of %d to %d\n", int64(f2),int64(f1));

