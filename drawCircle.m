function drawCircle(x, y, r )
theta = 0:2*pi/3600:2*pi;
% 利用极坐标得到圆的坐标
Circle1 = x + r*cos(theta);
Circle2 = y + r*sin(theta);
% 画圆
plot(Circle1, Circle2, '--k');
hold on;
end