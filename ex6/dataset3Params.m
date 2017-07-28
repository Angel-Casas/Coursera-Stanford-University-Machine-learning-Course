function [C, sigma] = dataset3Params(X, y, Xval, yval)
%DATASET3PARAMS returns your choice of C and sigma for Part 3 of the exercise
%where you select the optimal (C, sigma) learning parameters to use for SVM
%with RBF kernel
%   [C, sigma] = DATASET3PARAMS(X, y, Xval, yval) returns your choice of C and 
%   sigma. You should complete this function to return the optimal C and 
%   sigma based on a cross-validation set.
%

% You need to return the following variables correctly.
C = 1;
sigma = 0.3;

% ====================== YOUR CODE HERE ======================
% Instructions: Fill in this function to return the optimal C and sigma
%               learning parameters found using the cross validation set.
%               You can use svmPredict to predict the labels on the cross
%               validation set. For example, 
%                   predictions = svmPredict(model, Xval);
%               will return the predictions on the cross validation set.
%
%  Note: You can compute the prediction error using 
%        mean(double(predictions ~= yval))
%

% Vector representation of all the values of C and sigma we will test for this SVM.
values = [0.01 0.03 0.1 0.3 1 3 10 30];

% Initiate error as a big value. During iterations the lowest error will be saved.
error = inf;
% Iterate over the values to find out best possible set of C and sigma; this will bring 8^2 different possibilities.
for C_ = values
	for sigma_ = values
		model = svmTrain(X, y, C_, @(x1, x2) gaussianKernel(x1, x2, sigma_));
		predictions = svmPredict(model, Xval);
		error_ = mean(double(predictions ~= yval));
		if (error_ <= error)
			error = error_;
			C = C_;
			sigma = sigma_;
			fprintf('\n New error: %f \n[C sigma] = [%f %f]', error, C, sigma);
		endif
	endfor
endfor

fprintf('\nTraining done,  final values of C and sigma chosen, respectively: \n[C, sigma] = [%f %f] \n With an error = %f\n', C, sigma, error);




% =========================================================================

end
