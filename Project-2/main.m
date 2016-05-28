% Main function

% Load data
load('data.mat');

T = ip(:, 1);
X = ip(:, 2);
Y = ip(:, 3);

h = 0.2;

choice = input('Press 1 to plot path, \nother keys to plot velocity field: ', 's');

if choice == '1'
    tt = (linspace(0, 6.2, 10000))';
    len = size(tt, 1); dx = zeros(len, 1); dy = zeros(len, 1);

    for i = 1 : len
        [dx(i) dy(i)] = track(T, X, Y, tt(i));
    end

    plot(dx, dy);
    legend('Path of Vehicle');
else
    len = size(T, 1);

    speed = @(S) S(:, 2) + 2 * S(:, 3) * h + 3 * S(:, 4) * h^2;

    cx = cspline(T, X); cy = cspline(T, Y);
    u = [cx(:, 2) cy(:, 2); speed(cx(len-1, :)) speed(cy(len-1, :))];

    % Three point end point
    v0 = [tpe([X(1); X(2); X(3)], h) ... 
          tpe([Y(1); Y(2); Y(3)], h)];
    vn = [tpe([X(len); X(len-1); X(len-2)], -h) ...
          tpe([Y(len); Y(len-1); Y(len-2)], -h)];

    % Three point mid point

    v = [v0; tpm(X, h) tpm(Y, h); vn];

    quiver(X, Y, u(:, 1), u(:, 2));
    hold on;
    quiver(X, Y, v(:, 1), v(:, 2), 'r');
    legend('Cubic Spline Method', 'Three-point Method');
end

