clf;
clc;
clear;
hold on
m = 200;
X1 = [randn(m,1) randn(m,1)];   
scatter(X1(:,1),X1(:, 2),'filled');
X2 = [randn(m,1) + 4 randn(m,1) + 4];
scatter(X2(:,1),X2(:, 2),'filled');

% построение Х

X1 = [X1 -ones(m, 1)];
X2 = [-X2 ones(m, 1)];

X = [X1; X2];

% тренировка перцептрона

theta = mean(X);
trainingRuns = 1000;
step = 10;
power = 1.5;
eps = 0.01;
iter = 0;
plots = [];
borders = [0 3];
for i = [1:trainingRuns]
   iter = iter + 1;
   defaultTheta = theta;
   [temp, minVector] = min(X*theta');
   theta = theta + X(minVector, :) * (1/i^power);
   if (rem(i, step) == 1)
        plots = [plots; (theta(3)-borders.*theta(1))/theta(2)];
   end
   if (norm(defaultTheta - theta) < eps)
       break
   end
end
% plot(borders, (theta(3)-borders.*theta(1))/theta(2),'.-r', 'Color', c(i, :));

if (temp >= 0)
    disp("Линейно разделимы")
else
    disp("Линейно неразделимы")
end
iter

c = hsv(floor(iter*2/step));
for i = 1:floor(iter/step)
    plot(borders, plots(i,:),'.-r', 'Color', c(i, :));
end


%hold off



