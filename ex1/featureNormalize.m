function [X_norm, mu, sigma] = featureNormalize(X)
%FEATURENORMALIZE Normalizes the features in X 
%   FEATURENORMALIZE(X) returns a normalized version of X where
%   the mean value of each feature is 0 and the standard deviation
%   is 1. This is often a good preprocessing step to do when
%   working with learning algorithms.

% You need to set these values correctly
X_norm = X;
mu = zeros(1, size(X, 2));
sigma = zeros(1, size(X, 2));

% ====================== YOUR CODE HERE ======================
% Instructions: First, for each feature dimension, compute the mean
%               of the feature and subtract it from the dataset,
%               storing the mean value in mu. Next, compute the 
%               standard deviation of each feature and divide
%               each feature by it's standard deviation, storing
%               the standard deviation in sigma. 
%
%               Note that X is a matrix where each column is a 
%               feature and each row is an example. You need 
%               to perform the normalization separately for 
%               each feature. 
%
% Hint: You might find the 'mean' and 'std' functions useful.
%       
for i=1:2,
	mu(:, i) = mean(X(:, i))
	sigma(:, i) = std(X(:, i))
	endfor

X_norm = (X .- mu) ./ sigma;


% mu
for p = 1:size(X, 2),
	mu(p) = mean(X(:, p));
endfor

% sigma
for p = 1:size(X, 2),
	sigma(p) = std(X(:, p));
endfor

% X_norm
for p = 1:size(X, 2)
	if (sigma(p) != 0)
		for i = 1:size(X, 1),
			x_norm(i, p) = (X(i, p) - mu(p)) / sigma(p);
		endfor
	else
		% Normalized values are all zero. sigma(p) == 0. mean is 0 and std is sigma(=0)
		X_norm(:, p) = zeros(size(X, 1), 1);
	end
endfor





% ============================================================

end
