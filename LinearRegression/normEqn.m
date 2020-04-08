function theta = normEqn(X, y, lambda)
    theta = zeros(size(X, 2), 1);
    global fitting_X = X;
    global fitting_y = y;
    global fitting_lambda = lambda;
    options = optimset("GradObj", "On", "MaxIter", num_iters);
    [theta, functionVal] = fminunc(@cost_wrapper, theta, options)
    clear fitting_X fitting_y
end
