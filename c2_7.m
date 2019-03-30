omu=[-0.5; 0.5];
osigma=[1; 1];
P=[0.5, 0.5];

n=[10, 50, 100, 200, 500, 1000];
miscnt=zeros(1, size(n, 2));
bound=zeros(1, size(n, 2));
erf=zeros(1, size(n, 2));
for i=1:size(n, 2)
    x=zeros(2, n(i));
    for j=1:2
        x(j, :)=mvnrnd(omu(j), osigma(j), n(i));
    end
    mu=mean(x, 2);
    sigma=[cov(x(1, :)'); cov(x(2, :)')];
    
    %Bhattacharyya bound
    k=1/8.*mu(2)/((sigma(1)+sigma(2))./2)*mu(2)'+...
        1/2.*log(det((sigma(1)+sigma(2))./2)/...
        sqrt(det(sigma(1))*det(sigma(2))));
    bound(i)=sqrt(P(1)*P(2))*exp(-k)*100;
    erf(i)=(1-pcorrect(mu, sigma, P))*100;
    
    for j=1:2
        for k=1:n(i)
            for p=1:2
                g(p)=judge(mu(p), sigma(p), P(j), x(j, k));
            end
            [tmp, idx]=max(g);
            if idx~=j
                miscnt(i)=miscnt(i)+1;
            end
        end
    end
    miscnt(i)=miscnt(i)/n(i)/2*100;
end

hold on
plot(n, miscnt, 'displayname', 'training error');
plot(n, bound, 'displayname', 'Bhattacharyya');
plot(n, erf, 'displayname', 'erf');
legend('location', 'best');
xlabel('sample');
ylabel('error rate%');
hold off

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