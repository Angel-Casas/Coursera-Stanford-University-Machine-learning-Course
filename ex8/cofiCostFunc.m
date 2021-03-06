function [J, grad] = cofiCostFunc(params, Y, R, num_users, num_movies, ...
                                  num_features, lambda)
%COFICOSTFUNC Collaborative filtering cost function
%   [J, grad] = COFICOSTFUNC(params, Y, R, num_users, num_movies, ...
%   num_features, lambda) returns the cost and gradient for the
%   collaborative filtering problem.
%

% Unfold the U and W matrices from params
X = reshape(params(1:num_movies*num_features), num_movies, num_features);
Theta = reshape(params(num_movies*num_features+1:end), ...
                num_users, num_features);

            
% You need to return the following values correctly
J = 0;
X_grad = zeros(size(X));
Theta_grad = zeros(size(Theta));

% ====================== YOUR CODE HERE ======================
% Instructions: Compute the cost function and gradient for collaborative
%               filtering. Concretely, you should first implement the cost
%               function (without regularization) and make sure it is
%               matches our costs. After that, you should implement the 
%               gradient and use the checkCostFunction routine to check
%               that the gradient is correct. Finally, you should implement
%               regularization.
%
% Notes: X - num_movies  x num_features matrix of movie features
%        Theta - num_users  x num_features matrix of user features
%        Y - num_movies x num_users matrix of user ratings of movies
%        R - num_movies x num_users matrix, where R(i, j) = 1 if the 
%            i-th movie was rated by the j-th user
%
% You should set the following variables correctly:
%
%        X_grad - num_movies x num_features matrix, containing the 
%                 partial derivatives w.r.t. to each element of X
%        Theta_grad - num_users x num_features matrix, containing the 
%                     partial derivatives w.r.t. to each element of Theta
%

% for i=1:num_movies % For every movie:
% 	for j=1:num_users % For every user:
% 		sq_diff = ((Theta(j, :) * X(i, :)')' - Y(i, j)) ^ 2;
% 		if (R(i, j) == 1) % Add cost value only if the user j has a rating for movie i.
% 			J = J + sq_diff;
% 		endif
% 	endfor
% endfor
% J = J / 2;

% Vectorized:
sq_diff = (X * Theta' - Y) .^ 2;
J = (sum(sum(R .* sq_diff))) / 2;
% Regularization:
J = J + lambda * sum(sum(Theta .^ 2)) / 2;
J = J + lambda * sum(sum(X .^ 2)) / 2;

% % Gradients:
% for i =1:num_movies % For every movie:
% 	for j=1:num_users % For every user:
% 		difference = (X(i, :) * Theta(j, :)' - Y(i, j));
% 		for k=1:num_features % For every Feature:
% 			if (R(i, j)==1)
% 				X_grad(i, k) = difference * Theta(j, k);
% 				Theta_grad(j, k) = difference * X(i, k);
% 			endif
% 		endfor
% 	endfor
% endfor

% Gradient X:
for i=1:num_movies
	idx = find(R(i, :)==1);
	Theta_tmp = Theta(idx, :);
	Y_tmp = Y(i, idx);
	X_grad(i, :) = (X(i, :) * Theta_tmp' - Y_tmp) * Theta_tmp;
	% Regularization:
	X_grad(i, :) = X_grad(i, :) + lambda * X(i, :); 
endfor

% Gradient Theta:
for j=1:num_users
	idx = find(R(:, j)==1)';
	X_tmp = X(idx, :);
	Y_tmp = Y(idx, j);
	Theta_grad(j, :) = (X_tmp * Theta(j, :)' - Y_tmp)' * X_tmp;
	% Regularization:
	Theta_grad(j, :) = Theta_grad(j, :) + lambda * Theta(j, :);
endfor











% =============================================================

grad = [X_grad(:); Theta_grad(:)];

end
