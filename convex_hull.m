clf;
clc;
clear;
hold on
xlim([-2 6])
ylim([-2 6])
m = 200;
X = [randn(m,1) randn(m,1)];
scatter(X(:,1), X(:, 2),'filled');
Y = [randn(m,1) + 4 randn(m,1) + 4];
scatter(Y(:,1), Y(:, 2),'filled');

x0 = X(1, :);
y0 = Y(1, :);
changed = 1;
eps = 0.001;
delta = eps/10000;

iteration = 1;
history = [];

while max(changed) && norm(x0-y0) > eps && iteration < 100000
    initX0 = x0;
    initY0 = y0;
    % фикс. x
    for i = [1:m]
        y = Y(i,:);
        alpha = ((x0 - y0)*(y - y0)');
        if (alpha > 0)
            alpha = alpha / norm(y-y0)^2;
            if (alpha > 1)
                y0 = y;
            else
                y0 = y0 + alpha*(y - y0);
            end
        end
    end
    % фикс. y
    for i = [1:m]
        x = X(i,:);
        alpha = ((y0 - x0)*(x - x0)');
        if (alpha > 0)
            alpha = alpha / norm(x-x0)^2;
            if (alpha > 1)
                x0 = x;
            else
                x0 = x0 + alpha*(x - x0);
            end
        end
    end
    % scatter([x0(1) y0(1)], [x0(2) y0(2)], log(iteration + 1)*5, 'filled');

    history = [history; x0 y0];
    changed = max([norm(initX0 - x0), norm(initY0 - y0)]) >= delta;
    iteration = iteration + 1;
end
iteration



if (norm(x0-y0) < eps) 
    disp("Не разделимы");
else
    vector = y0 - x0;
    ortog = [vector(2) -vector(1)]/norm(vector)*2;
    line = ones(2, 1)*[y0 + x0]/2 + [ortog; -ortog];
    plot(line(:, 1), line(:, 2),'.-r');

end
scatter(history(:,1:2:4), history(:, 2:2:4), [1:size(history, 1)]*200/size(history, 1), 'x', 'LineWidth', 1);