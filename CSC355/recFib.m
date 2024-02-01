function fn = recFib(n)
    f0 = 1;
    f1 = 1;
    f2 = 1;
    fprintf("n\tf_n\tr_n\n");
    fprintf("---------------\n");
    
   
    for i = 1:n-2
        fprintf("%d\t%d\t%.16f\n", i+1, f2, f2./f0);
        
        f2 = f1 + f0;
        f0 = f1;
        f1 = f2;
        

        

    end
    fprintf("%d\t%d\t%.16f\n", n, f2, f2./f0);



    fn = f2;
    
end