mu=[-0.5; 0.5];
sigma=[1; 1];
P=[0.5, 0.5];

%Bhattacharyya bound
k=1/8.*mu(2)/((sigma(1)+sigma(2))./2)*mu(2)'+...
    1/2.*log(det((sigma(1)+sigma(2))./2)/...
    sqrt(det(sigma(1))*det(sigma(2))));
bound=sqrt(P(1)*P(2))*exp(-k);

erf=1-pcorrect(mu, sigma, P);
fprintf('erf=%f%%\n', erf*100);

function ret=pcorrect(mu, sigma, Pw)
L=min(mu-sigma*5);
R=max(mu+sigma*5);
n=100000;
x=linspace(L, R, n);
p=zeros(2, size(x, 2));
p(1, :)=normpdf(x, mu(1), sigma(1));
p(2, :)=normpdf(x, mu(2), sigma(2));
ret=(sum(p(1, p(1, :)>p(2, :)))*Pw(1)+sum(p(2, p(2, :)>p(1, :)))*Pw(2))*(R-L)/n;
end