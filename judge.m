function ret=judge(mu, sigma, w, x)
%given normal distribution and priori probability return judge
    ret=-1/2.*(x-mu)/sigma*(x-mu)'-1/2.*log(det(sigma))+log(w);
end
