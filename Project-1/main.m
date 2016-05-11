% Main function

choice = input('Choose 1 for first function, 2 for the second, else for 3rd: ', 's');

if choice == '1'
	fprintf('First function: \n');

	f = @(x) (x + 3) * (x - 1)^4;
	a = -4;
	b = 4/3;
elseif choice == '2'
	fprintf('Second function: \n');

	f = @(x) cos(x^2) - 0.5 * x;
	a = 0;
	b = 2;
else
	fprintf('Third function: \n');

	f = @(x) cos(x^2) - x^3;
	a = 0;
	b = 1;
end

format long;
epsilon = 10^(-15);

fprintf('True Solution: '); 
sol = fzero(f, [a, b])

p1 = bisection(f, a, b, epsilon);
fprintf('Bisection result: ');
p1(size(p1, 2))

[p2, hist] = brent(f, a, b, epsilon);
fprintf('Brent result: '); 
p2(size(p2, 2))
fprintf('History of a, b, c: \n');
hist

SOL1 = abs(p1 - sol);
SOL2 = abs(p2 - sol);

semilogy(SOL1, 'r');
hold on;
semilogy(SOL2, 'b');
legend('Bisection Method', 'Brent Method');