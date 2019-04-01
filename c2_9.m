P1=[0.9, 0.1; 0.3, 0.7; 0.4, 0.6; 0.8, 0.2];
P2=[0.65, 0.35; 0.25, 0.75];
P3=[0.33, 0.33, 0.34; 0.8, 0.1, 0.1];
P4=[0.4, 0.6; 0.95, 0.05];


function ret=parent(A, B, C, D)
    ret=zeros(2, 1);
    for i=1:2
        for j=1:size(A, 1)
            for k=1:size(B, 1)
                ret(i)=ret(i)+P1(j, i)*A(j)*B(k);
            end
        end
    end
    tmp=ret;
    ret=zeros(2, 1);
    for i=1:2
         for j=1:size(C, 1)
             for k=1:size(D, 1)
                 ret(i)=ret(i)+P1(j, i)*A(j)*B(k);
             end
         end
     end
end