function drawCircle(x, y, r )
theta = 0:2*pi/3600:2*pi;
% ���ü�����õ�Բ������
Circle1 = x + r*cos(theta);
Circle2 = y + r*sin(theta);
% ��Բ
plot(Circle1, Circle2, '--k');
hold on;
end