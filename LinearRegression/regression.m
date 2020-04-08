clear
load data.mat


% test_X = testData(:, 1);
% test_y = testData(:, 2);
% train_X = trainData(:, 1);
% train_y = trainData(:, 2);

% outlierIndex = find(train_X > 200);
% train_X(outlierIndex) = [];
% train_y(outlierIndex) = [];

[train_X, train_y, test_X, test_y] = split(X, y, 450);

[train_X, mu, sigma] = normalize(train_X);
test_X = (test_X - mu) ./ sigma;
train_X = [ones(size(train_X, 1), 1), train_X];
test_X = [ones(size(test_X, 1), 1), test_X];

theta = descent(train_X, train_y, 0.1, 100, 0.01)

accuracy = evaluation(test_X, test_y, theta);
fprintf("Your model has a accuracy of %f%s\n", accuracy * 100, "%")

save model.mat theta