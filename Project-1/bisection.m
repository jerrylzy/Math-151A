function [p] = bisection(f, a, b, epsilon)
% BISECTION finds a root of f between a and b, requiring that f(a)f(b)<0
% p is a sequence of approximations for the root 
fa = f(a); fb = f(b);
if sign(fa)*sign(fb) > 0
    error('the function values should have opposite signs at two ends');
end

delta = epsilon*max(1,abs(b));
iter = 1;
fs = f(a);
while abs(fs)>epsilon || abs(a-b)>delta
    s = (b+a)/2;
    fs = f(s);
    if sign(fs)*sign(fa)>0
        a = s;
        fa = fs;
    else
        b = s;
        fb = fs;
    end
    p(iter) = s;
    iter = iter + 1;
end