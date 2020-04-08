function J = computeCost(X, y, theta)

    m = length(y); % number of training examples
    J = 0;
    prediction = X * theta;
    J = sum((prediction - y).^2) / (2 * m);

end
