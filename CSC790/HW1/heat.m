%% create tensor
xdim = 61; ydim = 41; tdim = 300;
[x,y] = meshgrid(linspace(0,6,xdim),linspace(0,4,ydim)); X = zeros(ydim,xdim,tdim);
% set initial conditions (set boundary values to zero)
X(:,:,1) = 100*exp(-.4*( (x-1).^2 + .7*(y-3).^2 )) + ... 
    80*exp(-.2*( 2*(x-5).^2 + 1.5*(y-1).^2 )); 
X(1,:,1) = 0; X(end,:,1) = 0; X(:,1,1) = 0; X(:,end,1) = 0;
% simulate through time to fill tensor
for i = 1:tdim -1
    % compute each entry of next step as average of NSEW neighbors 
    X(2:end-1,2:end-1,i+1) = ( X(1:end-2,2:end-1,i) + ...
                               X(3:end,2:end-1,i) + ...
                               X(2:end-1,1:end-2,i) + ... 
                               X(2:end-1,3:end,i) ) / 4;
end
% cast as Tensor Toolbox tensor object
Xt = tensor(X);

%% visualize surface plots over time steps
figure,
for t = 1:tdim
    % surface plot 
    surf(x(2:end-1,2:end-1),y(2:end-1,2:end-1),X(2:end-1,2:end-1,t))
    % fix axis
    axis([0 6.1 0 4.1 0 100]), colormap('hot'), title('Original')
    pause (.001)
end

%% compute Tucker approximation with 1e-1 tolerance
T = hosvd(Xt,1e-1);

%% visualize surface plots over time steps of approximation
Y = double(full(T));
figure,
for t = 1:tdim
    % surface plot 
    surf(x(2:end-1,2:end-1),y(2:end-1,2:end-1),Y(2:end-1,2:end-1,t))
    % fix axis
    axis([0 6.1 0 4.1 0 100]), colormap('hot'), title('Approximation')
    pause (.001)
end

%% visualize 1st time slice and compare exact with approximation
figure, heatmap(X(:,:,1)), colormap('hot'), title('Original')
figure, heatmap(Y(:,:,1)), colormap('hot'), title('Approximation')

%% compute compression ratio
comp_ratio = whos('X').bytes / whos('T').bytes

%%
figure,
x = [1:300];
scatter(x,Xt(1,1,:))
%% frontal slice
figure,
surf(x(2:end-1,2:end-1),y(2:end-1,2:end-1),X(2:end-1,2:end-1,1))



%% lateral
[x1,y1] = meshgrid(linspace(0,6,tdim),linspace(0,4,ydim));
test = reshape(X(2:end-1,20,2:end-1),39,298);
figure,
surf(x1(2:end-1,2:end-1),y1(2:end-1,2:end-1),test)

%% horizontal
[x2,y2] = meshgrid(linspace(0,6,tdim),linspace(0,4,xdim));
test2 = reshape(X(20,2:end-1,2:end-1),59,298);
figure,
surf(x2(2:end-1,2:end-1),y2(2:end-1,2:end-1),test2)
%% Tucker decom with 1e-2
T2 = hosvd(Xt,1e-2);
comp_ratio2 = whos('X').bytes / whos('T').bytes








