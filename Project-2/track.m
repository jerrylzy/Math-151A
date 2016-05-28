function [fx, fy] = track(T, X, Y, t)
	%	Input T: vector of interpolating points;
	%		  X: distances of x at interpolating points;
	%		  Y: distances of y at interpolating points;
	%		  t: the time being approximated for tracking.
    %   This function will approximate with cubic spline.

	len = size(T, 1);

	if t > T(len) || t < T(1)
        error('t does not fall in the range of approximation');
    end
    
    CX = cspline(T, X);
    CY = cspline(T, Y);
    
    index = 0;
    
    for i = 1 : len - 1
        if T(i) <= t && T(i+1) >= t
            index = i;
            break
        end
    end

    h = t - T(index);
    sxcoeff = CX(index, :);
    sycoeff = CY(index, :);
    fx = sxcoeff(1) + sxcoeff(2) * h + sxcoeff(3) * h^2 + sxcoeff(4) * h^3;
    fy = sycoeff(1) + sycoeff(2) * h + sycoeff(3) * h^2 + sycoeff(4) * h^3;
end