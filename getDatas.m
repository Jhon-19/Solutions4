clear;
clc;
filePath = 'E:\ѧϰ�ļ�\��ģ\��ѵ\ģ����\ģ����4\��������';
fileName = '����һ���ѽ�����Ŀ��������.xls';
[num, txt, raw] = xlsread([filePath, '\', fileName]);
close all;
len = length(num);
index0 = 1;
index1 = 1;
for i = 1:1:len
    if num(i, 4) == 0
        num0(index0, 1) = num(i, 1);
        num0(index0, 2) = num(i, 2);
        num0(index0, 3) = num(i, 3);
        index0 = index0+1;
    elseif num(i, 4) == 1
        num1(index1, 1) = num(i, 1);
        num1(index1, 2) = num(i, 2);
        num1(index1, 3) = num(i, 3);
        index1 = index1+1;
    end
end
figure;
plot3(num0(:, 1), num0(:, 2), num0(:, 3), '.');
hold on;
plot3(num1(:, 1), num1(:, 2), num1(:, 3), '.');
hold off;
grid on;
figure;
plot(num0(:, 1), num0(:, 2), '.');
hold on;
plot(num1(:, 1), num1(:, 2), '.');
hold off;
grid on;