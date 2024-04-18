function [f,g,H] = myfun(vx,c)
% computes function value, gradient, and Hessian
x = vx(1,:); y = vx(2,:);
% compute function value
f = c*(y-x.^2).^2 + (1-x).^2;
if nargout > 1
    % compute gradient
    g = [-4*c*(x*(y - x.^2)) - 2*(1 - x); 2*c*(y - x.^2)]; % fixme
    if nargout > 2
        % compute Hessian
        H = [-c*(4*y - 12*x.^2) + 2, -4*c*x; -4*c*x, 2*c]; % fixme
    end
end

end