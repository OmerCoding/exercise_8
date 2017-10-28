function [J, grad] = cofiCostFunc(params, Y, R, num_users, num_movies, ...
                                  num_features, lambda)

                                  
X = reshape(params(1:num_movies*num_features), num_movies, num_features);
Theta = reshape(params(num_movies*num_features+1:end), ...
                num_users, num_features);

            

J = 0;
X_grad = zeros(size(X));
Theta_grad = zeros(size(Theta));


all_val = X * Theta';

all_val = R .* all_val;

y = R .* Y;

X_for_reg = X .^ 2;

Theta_for_reg = Theta .^ 2;

J_before_sum = 0.5 * ((all_val - y) .^ 2);

J = sum(sum(J_before_sum)) + (lambda / 2) * (sum(sum(X_for_reg)) + sum(sum( ...
Theta_for_reg)));

X_grad = ((all_val - y) * Theta) + lambda * X;

Theta_grad = ((all_val - y)' * X) + lambda * Theta;




grad = [X_grad(:); Theta_grad(:)];

end
