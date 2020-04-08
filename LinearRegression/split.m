function [train_X, train_y, test_X, test_y] = split(X, y, trainSize)
    dataSetSize = length(y);
    randIndex = randperm(dataSetSize);
    train_X = X(randIndex(1:trainSize), :);
    test_X = X(randIndex(trainSize + 1: dataSetSize), :);
    train_y = y(randIndex(1:trainSize), :);
    test_y = y(randIndex(trainSize + 1:dataSetSize), :);
