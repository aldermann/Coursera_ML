function p = predict(Theta1, Theta2, X)
    %PREDICT Predict the label of an input given a trained neural network
    %   p = PREDICT(Theta1, Theta2, X) outputs the predicted label of X given the
    %   trained weights of a neural network (Theta1, Theta2)

    % Useful values
    m = size(X, 1);
    num_labels = size(Theta2, 1);


    a2 = sigmoid(Theta1 * PrependWithOne(X'));
    a3 = sigmoid(Theta2 * PrependWithOne(a2));
    [_, p] = max(a3);
    p = p';
end

function newA = PrependWithOne(A)
    l = size(A, 2);
    newA = [ones(1, l); A];
end