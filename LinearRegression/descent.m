% function [theta, J_history] = fit(X, y, alpha, num_iters, lambda)
%     theta = zeros(size(X, 2), 1);
%     m = length(y);
%     for iter = 1:num_iters
%         [J, delta] = cost(X, y, theta);
%         J_history(iter) = J;
%         theta = theta - delta * alpha
%     end
%     % figure(2)
%     plot(J_history)
% end

function theta = descent(X, y, alpha, num_iters, lambda)
    theta = zeros(size(X, 2), 1);
    global fitting_X = X;
    global fitting_y = y;
    global fitting_lambda = lambda;
    options = optimset("GradObj", "On", "MaxIter", num_iters);
    [theta, functionVal] = fminunc(@cost_wrapper, theta, options);
    clear fitting_X fitting_y
end

function [theta, delta] = cost_wrapper(theta)
    global fitting_X;
    global fitting_y;
    global fitting_lambda;
    [theta, delta] = cost(fitting_X, fitting_y, theta, fitting_lambda);
end;