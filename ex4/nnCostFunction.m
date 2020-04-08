function [J grad] = nnCostFunction(nn_params, ...
        input_layer_size, ...
        hidden_layer_size, ...
        num_labels, ...
        X, y, lambda)
    
    m = size(X, 1);
    X = X';
    Y = prepareY(y, num_labels)';
    Theta1 = reshape(nn_params(1:hidden_layer_size * (input_layer_size + 1)), ...
        hidden_layer_size, (input_layer_size + 1));

    Theta2 = reshape(nn_params((1 + (hidden_layer_size * (input_layer_size + 1))):end), ...
        num_labels, (hidden_layer_size + 1));

    % Setup some useful variables

    % You need to return the following variables correctly

    [A2, A3] = forwardProp(X, Theta1, Theta2);
    J = sumAll(Y .* log(A3) + (1 .- Y) .* log(1 .- A3)) * (-1 / m);

    theta1_weight = Theta1(:, [2:end]);
    theta2_weight = Theta2(:, [2:end]);
    reg_term = (sumAll(theta1_weight.^2) + sumAll(theta2_weight.^2)) * lambda / (2 * m);
    J = J + reg_term;

    [Theta1_grad, Theta2_grad] = backProp(X, A2, A3, Y, Theta1, Theta2, lambda);

    % Unroll gradients
    grad = [Theta1_grad(:); Theta2_grad(:)];

end

function Y = prepareY(y, num_labels)
    Y = zeros(length(y), num_labels);

    for i = 1:length(y)
        Y(i, y(i)) = 1;
    end

end

function [A2, A3] = forwardProp(X, Theta1, Theta2)
    A2 = sigmoid(Theta1 * PrependWithOne(X));
    A3 = sigmoid(Theta2 * PrependWithOne(A2));
end

function newA = PrependWithOne(A)
    l = size(A, 2);
    newA = [ones(1, l); A];
end

function s = sumAll(A)
    s = sum(sum(A));
end

function [Delta1, Delta2] = backProp(A1, A2, A3, Y, Theta1, Theta2, lambda)
    A2 = PrependWithOne(A2);
    A1 = PrependWithOne(A1);
    Delta1 = zeros(size(Theta1));
    Delta2 = zeros(size(Theta2));
    m = size(Y, 2);
    for i = 1:m
        y = Y(:, i);
        a3 = A3(:, i);
        a2 = A2(:, i);
        a1 = A1(:, i);
        d3 = a3 - y;
        d2 = Theta2' * d3 .* a2 .* (1 - a2);
        Delta1 = Delta1 + d2(2:end) * a1'; 
        Delta2 = Delta2 + d3 * a2';
    end
    Theta2(:, 1) = [0];
    Theta1(:, 1) = [0];
    Delta2 = (Delta2 + lambda * Theta2) / m;
    Delta1 = (Delta1 + lambda * Theta1) / m;
end
