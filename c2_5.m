figure(1);
fprintf('10000 samples\n');
rand_and_calc(10000);

figure(2);
fprintf('100000 samples\n');
rand_and_calc(100000);

figure(3);
fprintf('1000000 samples\n');
rand_and_calc(1000000);

function rand_and_calc(m)
    x=zeros(1, m);
    cnt=0;
    while (cnt<m)
        rx=rand3();
        if (cnt+size(rx, 2)>m)
            rx=rx(1:m-cnt);
        end
        x(cnt+1:cnt+size(rx, 2))=rx;
        cnt=cnt+size(rx, 2);
    end
    histogram(x);
    fprintf('mean: %f\n standard deviation: %f\n', mean(x), sqrt(cov(x')));
end

function rx=rand3()
    xl=0; xr=0;
    while (xl==xr)
        xl=randi([-100, 100], 1);
        xr=randi([-100, 100], 1);
    end
    if (xl>xr)
        tmp=xl;
        xl=xr;
        xr=tmp;
    end
    n=randi([1, 1000], 1);
    rx=randi([xl, xr], 1, n);
end