cla reset
data = load("ex2data1.txt");
X = data(:, [1, 2]); y = data(:, 3);
hold on
plotData(X, y);
m = size(X, 1);
X = [ones(m, 1) X];
initial_theta = zeros(size(X, 2), 1);

% Set regularization parameter lambda to 1 (you should vary this)
lambda = 1;

% Set Options
options = optimset('GradObj', 'on', 'MaxIter', 400);

% Optimize
[theta, J, exit_flag] = fminunc(@(t)(cost(t, X, y, lambda)), initial_theta, options);
plot_x = [min(X(:, 2)) - 2, max(X(:, 2)) + 2];

% Calculate the decision boundary line
plot_y = (-1 ./ theta(3)) .* (theta(2) .* plot_x + theta(1));

% plot(rx, -theta(1)/theta(2) * rx - theta(3)/theta(2))
plot(plot_x, plot_y);
hold off