mu=[1, 0; -1, 0];
sigma(:, :, 1)=eye(2);
sigma(:, :, 2)=eye(2);
P=[0.5, 0.5];

n=50:50:500;
miscnt=zeros(1, size(n, 2));
for i=1:size(n, 2)
    for j=1:2
        x=mvnrnd(mu(j, :), sigma(:, :, j), n(i));
        for k=1:n(i)
            for p=1:2
                g(p)=judge(mu(p, :), sigma(:, :, p), P(j), x(k, :));
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

%Bhattacharyya bound
k=1/8.*mu(2, :)/((sigma(:, :, 1)+sigma(:, :, 2))./2)*mu(2, :)'+...
    1/2.*log(det((sigma(:, :, 1)+sigma(:, :, 2))./2)/...
    sqrt(det(sigma(:, :, 1))*det(sigma(:, :, 2))));
bound=sqrt(P(1)*P(2))*exp(-k);

plot(n, ones(1, size(n, 2))*bound*100, 'displayname', 'Bhattacharyya bound');

legend('location', 'best');
xlabel('n');
ylabel('%');
hold on

