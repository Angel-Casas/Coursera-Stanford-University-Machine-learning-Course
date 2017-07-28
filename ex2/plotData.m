function plotData(X, y)
%PLOTDATA Plots the data points X and y into a new figure 
%   PLOTDATA(x,y) plots the data points with + for the positive examples
%   and o for the negative examples. X is assumed to be a Mx2 matrix.

% Create New Figure
figure; hold on;

% ====================== YOUR CODE HERE ======================
% Instructions: Plot the positive and negative examples on a
%               2D plot, using the option 'k+' for the positive
%               examples and 'ko' for the negative examples.
%

X_pass = find(y == 1);
X_fail = find(y == 0);

plot(X(X_pass, 1), X(X_pass, 2), 'r+', 'LineWidth', 2, 'MarkerSize', 7);
plot(X(X_fail, 1), X(X_fail, 2), 'ko', 'LineWidth', 2, 'MarkerSize', 7);
axis([0, 100, 0, 100])
xlabel("Score 1")
ylabel("Score 2")









% =========================================================================



hold off;

end
