function acc = evaluation(X, y, theta)
    f = X * theta;
    y_mean = mean(y);
    ss_tot = sum((y .- y_mean) .^ 2);
    ss_res = sum((y - f) .^ 2);
    acc = 1 - ss_res / ss_tot;
