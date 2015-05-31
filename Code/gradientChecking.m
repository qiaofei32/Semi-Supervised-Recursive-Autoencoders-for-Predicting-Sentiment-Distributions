function [e] = gradientChecking(fun, theta, ei, datacell, output, vocabulary, just_pred)
  %
  % Arguments:
  %   fun - Accepts the function over which the gradient has to be verified
  %   theta - A column vector containing the parameter values to optimize.
  %   checks - The number of checks which have to be performed
  %   X - The examples stored in a matrix.  
  %       X(i,j) is the i'th coordinate of the j'th example.
  %   y - The label for each example.  y(j) is the j'th example's label.
  %

epsilon = 0.0001;
e = 0;
[~,g,~] = fun(theta, ei, X, y,false);
size(g)

for j = 1:checks
    i = randsample(numel(theta),1);  
    
    thetap = theta;
    thetap(i) = thetap(i) + epsilon;
    [fp, ~, ~] = fun(thetap, ei, datacell, output, vocabulary, just_pred);
    
    thetan = theta;
    thetan(i) = thetan(i) - epsilon;
    [fn, ~, ~] = fun(thetan, ei, datacell, output, vocabulary, just_pred);
    
    g1 = (fp - fn)/2*epsilon;
    e1 = abs(g(i)-g1);
     
    e = e + e1;
    if mod(j, 10) == 0
        fprintf('%f, %f, %f - values\n', i, j, e/j);
    end
end
e = e/checks;
