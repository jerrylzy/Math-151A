function [S] = cspline(X, F)
    % Input: X: vector of [x0; x1; x2; ...; xn], len = n + 1
    %        F: vector of [f0; f1; f2; ...; fn], len = n + 1
    % We assume natural boundary conditions, where
    % c_0 = c_n = 0
    % This will return a matrix of coefficients 
    % for the cubic spline
    % f_0       b_0     c_0     d_0
    % ...       ...     ...     ...
    % f_n-1     b_n-1	c_n-1   d_n-1
    % This implementation heavily uses vectorization, which
    % gives a noticeable speed boost.

    len = size(X, 1);   % n + 1
    n = len - 1;
    
    if len ~= size(F, 1)
        error('Length of the two parameters do not agree')
    end

    % Initialize h vector, h_k = x_{k+1} - x_k, k = 0, 1, ..., n - 1
    H = X(2 : len) - X(1 : n);
   
    % Setup coefficient c_i equation matrix
    CMAT = zeros(len, len);
    CMAT(1,1) = 1; CMAT(len, len) = 1;

    for i = 2 : n % j = 1 : n - 1
        CMAT(i, i-1) = H(i-1); % h_{j-1}c_{j-1}
        CMAT(i, i) = 2 * (H(i-1) + H(i)); % 2(h_j + h_{j-1})c_j
        CMAT(i, i+1) = H(i); % h_jc_j
    end

    % Vectorized matrix r setup
    % R = [r0; r1; r2; ...; rn]
    
    % Hoist
    F2n = F(2 : n);
    
    R = [0; 3 * ((F(3 : len) - F2n) ./ H(2 : n) - ...
        (F2n - F(1 : n-1)) ./ H(1 : n-1)); 0];

    % Solve coefficients c_i's to get c vector
    C = CMAT \ R;

    % Vectorized b / d coefficients vectors setup
    
    % Hoist
    F2len = F(2 : len); F1n = F(1 : n);
    C2len = C(2 : len); C1n = C(1 : n);
    
    B = (F2len - F1n) ./ H - (H .* (C2len + 2 * C1n)) / 3;
    D = (C2len - C1n) ./ (3 * H);
    
    % f(2 : len) = [f1; f2; ...; fn], c(2 : len) = [c1; c2; ...; cn]
    S = [F1n B C1n D];

end