function [p, hist] = brent(f, a, b, epsilon)
    % f: function, (a, b) end points, epsilon accuracy

    % Inverse quadratic interpolation
    invquad = @(a, fa, fb, fc) (a * fb * fc) / ((fa - fb) * (fa - fc));

    % Check signs
    fa = f(a); fb = f(b);
    if sign(fa)*sign(fb) > 0
        error('the function values should have opposite signs at two ends');
    end

    % Swap a and b if needed
    if abs(fa) < abs(fb)
        [a, b] = deal(b, a);
        [fa, fb] = deal(fb, fa);
    end

    % Initialize Variables
    c = a;
    isBisect = true;
    delta = epsilon * max(1, abs(b));
    iter = 1;
    hist = [a, b, c];

    while abs(fb) > epsilon || abs(b - a) > delta
        fc = f(c);
        if abs(fa - fc) > epsilon && abs(fb - fc) > epsilon
            s = invquad(a, fa, fb, fc) + invquad(b, fb, fa, fc) + invquad(c, fc, fa, fb);
        else % Use secant method
            s = b - (fb * (b - a)) / (fb - fa);
        end

        % Simplify conditions from pseudocode
        if sign(s - (3 * a + b) / 4) * sign(s - b) > 0
            useBisect = true;
        elseif isBisect
            absbc = abs(b - c);
            useBisect = abs(s - b) >= absbc / 2 || absbc < delta;
        else
            abscd = abs(c - d);
            useBisect = abs(s - b) > abscd / 2 || abscd < delta;
        end

        % Determine whether we need to calculate s by bisection method.
        isBisect = useBisect;
        if useBisect
            s = (a + b) / 2;
        end

        d = c;
        c = b;
        if sign(fa) * sign(f(s)) < 0
            b = s;
        else
            a = s;
        end

        fa = f(a); fb = f(b); 

        % Swap a, b if needed
        if abs(fa) < abs(fb)
            [a, b] = deal(b, a);
            [fa, fb] = deal(fb, fa);
        end

        % Update variables
        delta = epsilon * max(1, abs(b));
        p(iter) = b;
        iter = iter + 1;
        hist = [hist; a, b, c];
    end

