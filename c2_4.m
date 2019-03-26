x1=[-5.01, -5.43, 1.08, 0.86, -2.67, 4.94, -2.51, -2.25, 5.56, 1.03;
    -0.91 1.30, -7.75, -5.47, 6.14, 3.60, 5.37, 7.18, -7.39, -7.50; 
    5.35, 5.12, -1.34, 4.48, 7.11, 7.17, 5.75, 0.77, 0.90, 3.52];
x2=[-8.12, -3.48, -5.52, -3.78, 0.63, 3.29, 2.09, -2.13, 2.86, -3.33;
    -0.18,-2.06, -4.54, 0.50, 5.72, 1.26, -4.63, 1.46, 1.17, -6.32;
    2.26, 3.22, -5.31, 3.42, 2.39, 4.33, 3.97, 0.27, -0.43, -0.36];
x3=[-3.68, -3.54, 1.66, -4.11, 7.39, 2.08, -2.59, -6.94, -2.26, 4.33;
    -0.05, -3.53, -0.95, 3.92, -4.85, 4.36, -3.65, -6.66, 6.30, -0.31;
    8.13, -2.66, -9.87, 5.19, 9.21, -0.98, 6.65, 2.41, -8.71, 6.43];
mu=zeros(3, 3);
sigma=zeros(3, 3, 3);
for i=1:3
    xi=[x1(i, :)', x2(i, :)', x3(i, :)'];
    mu(i, :)=mean(xi, 1);
    sigma(:, :, i)=cov(xi);
end
P=[1/3, 1/3, 1/3];
testp=[1, 2, 1; 5, 3, 2; 0, 0, 0; 1, 0, 0];
r=zeros(size(testp, 1), 3);

for i=1:size(testp, 1)
    for j=1:3
        r(i, j)=mahaldis(mu(j, :), sigma(:, :, j), testp(i, :));
        fprintf('the Mahalanobis of test point %d to type %d is %f\n', i, j, r(i, j));
    end
end

type=ones(1, size(testp, 1));
g=zeros(1, 3);
for i=1:size(testp, 1)
    for j=1:3
        g(j)=judge(mu(j, :), sigma(:, :, j), P(j), testp(i, :));
    end
    [tmp, type(i)]=max(g);
end

plot3(testp(type==1, 1), testp(type==1, 2), testp(type==1, 3), 'ro', 'displayname', '\omega 1');
hold on
plot3(testp(type==2, 1), testp(type==2, 2), testp(type==2, 3), 'bo', 'displayname', '\omega 2');
plot3(testp(type==3, 1), testp(type==3, 2), testp(type==3, 3), 'go', 'displayname', '\omega 3');
xlabel('x1');
ylabel('x2');
zlabel('x3');
legend;
hold off

%misclassificaiton
miscnt=0;
for i=1:3
    for j=1:10
        xi=[x1(i, j), x2(i, j), x3(i, j)];
        for k=1:3
            g(k)=judge(mu(k, :), sigma(:, :, k), P(k), xi);
        end
        [tmp, idx]=max(g);
        if (~(idx==i))
            miscnt=miscnt+1;
        end
    end
end
fprintf('misclassification %f%%\n', miscnt/30*100);

