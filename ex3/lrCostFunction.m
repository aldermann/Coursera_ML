function [J, grad] = lrCostFunction(theta, X, y, lambda)
    m = length(y);
    grad = zeros(size(theta));
    h = sigmoid(X * theta);
    theta(1) = 0;
    reg_cost = lambda / (2 * m) * theta' * theta;
    J = (-y' * log(h) - (1 - y)' * log(1 - h)) / m + reg_cost;
    grad = (X' * (h - y) + theta * lambda) / m;
    grad = grad(:);
end
