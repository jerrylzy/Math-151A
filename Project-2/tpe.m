function [res] = tpe(F, h)
	% Input: F: vector of function values [f_0 f_1 f_2]
	% Output: res: result of three-point midpoint approximation
	
	res = 1/h * (-1.5 * F(1) + 2 * F(2) - 0.5 * F(3));

end