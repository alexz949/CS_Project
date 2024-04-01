function q = adaptivequad(f,a,b,tol)
    fa = f(a);
    fb = f(b);
    q = aq_cts_step(f,a,b,fa,fb,tol);
end

function q = aq_cts_step(f,a,b,fa,fb,tol)
    c = (a+b)/2;
    fc = f(c);
    h = c-a;
    tra = h * (1/2*fa + fb + 1/2*fc);
    sim = 1/3*h*(fa+4*fb+fc);
    if abs(tra - sim) < tol
        q = sim;
        return;
    else
        q = aq_cts_step(f,a,c,fa,fc,tol) + aq_cts_step(f,c,b,fc,fb,tol);        
    end
end