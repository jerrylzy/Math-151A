function [v] = tpm(F, h)
	% Input:  F: vector of function values [f_0; f_1; ...; f_n]
	%	      h: step size
	% Output: v: vector of approximated derivative [f'_0; f'_1; ...; f'_n]
	%			 using three point mid point method

	len = size(F, 1);
	v = (F(3:len) - F(1 : len-2)) / (2 * h);

end