%Spencer Plavoukos and Alex Zhang

%problem (1)
t = linspace(0,1,50);
t = t';
A = vander(t);
A = A(:,end-12+1:end);
b = cos(4*t);

%problem (2)
%(a)
tic
G = A'*A;
y = A'*b;
x = G \ y;
toc

%(b)
tic 
[Q,R] = mgs(A);
y_1 = Q'*b;
x_1 = R \ y_1;
toc

%(c)
tic
[Q_1,R_1] = qr(A);
y_2 = Q_1' * b;
x_2 = R_1 \ y_2;
toc

%(d)
tic
[U,S,V] = svd(A);
y_3 = U' * b;
z = S \ y_3;
x_3 = V * z;
toc

%(e)
tic
x_4 = polyfit(t,b,11);
x_4 = x_4';
toc

%problem 3
M = zeros(12,5);
M(:,1) = x;
M(:,2) = x_1;
M(:,3) = x_2;
M(:,4) = x_3;
M(:,5) = x_4;
disp(M);

%problem (4)
%(a)
%The last three solution do not differ a lot. They have some differenences after 10^-9.
%However, the first column and the second column are kind of vary in
%entries.
%(b)
%I will not trust the normal eqaution since it differs a lot from other result.
%I may choose to trust the polyfit one since I guess there is no 
%matrix multiplication or division which may cause numerical instability.
%(c)
%I think it should be doing the sum of residual and calculating the
%standard deviation and fit the line in statictic way.
                                                                                                    
%problem (5)
%(a)
%I cannot see any difference unless I zoom in the data into 10^-7.
%(b)
figure(1)
plot(t,b,t,A*x_4,t,A*x);
legend('cos(4t)','polyfit','normal');
title('Curves for Different Methods Least Square Approach');
xlabel('t');
ylabel('Least Square Curve');
fontsize(gca,10,"pixels");
grid

%problem (6)
%Calculate the average run time for 5 runs. (a) has average of 0.0009162,
%(b) has 0.001425, (c) has 0.000527, (d) has 0.0004956, and (e) has
%0.0004292. Based on the result, polyfit method is fastest and QR with MGS
%is the slowest. I will still recommend using polyfit method since it is
%fastest.


function [Q,R] = mgs(A)

    [m,n] = size(A); % number of columns of A
    
    R = zeros(n); % initialize Q,R matrices
    Q = zeros(m,n);

    for j = 1:n
        w = A(:,j); % initialize vector

        for i = 1:j-1
            R(i,j) = Q(:,i)'*w;  % this part is different from CGS

            w = w - R(i,j)*Q(:,i); 
        end
        R(j,j) = norm(w);
        Q(:,j) = w/R(j,j);  % normalize 
    end
end




