function [J, grad] = cost(theta, X, y, lambda)
    m = length(y);
    h = sigmoid(X * theta);
    theta(1) = 0;
    reg_cost = (lambda / (2 * m)) * (theta' * theta);
    J = (-y' * log(h) - (1 - y)' * log(1 - h)) / m + reg_cost;
    grad = (X' * (h - y) + theta * lambda) / m;
end

% function [J, grad] = cost(theta, X, y)
%     m = length(y);
%     h = sigmoid(X * theta);
%     J = (-y' * log(h) - (1 - y)' * log(1 - h)) / m;
%     grad = X' * (h - y) / m;

% end
