function plotData (X, y)
    scatter(X(y == 1, 1), X(y == 1, 2), 30, "x");
    scatter(X(y == 0, 1), X(y == 0, 2), 30, "o");
end