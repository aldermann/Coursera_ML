function [J, delta] = cost(X, y, theta, lambda)
    m = length(y);
    J = 0;
    predictions = X * theta;
    J = sum((predictions - y).^2) / (2 * m) + lambda * sum(theta .^ 2) / (2 * m);
    dif = predictions - y;
    r = theta * lambda / m;
    r(1) = 0;
    delta = (1 / m) * X' * dif + r;

end
