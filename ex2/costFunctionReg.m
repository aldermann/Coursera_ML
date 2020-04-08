function [J, grad] = costFunctionReg(theta, X, y, lambda)
    m = length(y);
    h = sigmoid(X * theta);
    theta(1) = 0;
    reg_cost = (lambda / (2 * m)) * (theta' * theta);
    J = (-y' * log(h) - (1 - y)' * log(1 - h)) / m + reg_cost;
    grad = (X' * (h - y) + theta * lambda) / m;
end
