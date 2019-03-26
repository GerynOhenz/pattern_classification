function r = mahaldis(mu,sigma, x)
%given mu and sigma, return Mahalanobis distance r
    r=(x-mu)/sigma*(x-mu)';
end

