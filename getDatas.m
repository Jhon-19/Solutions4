clear;
clc;
%��ȡexcel�����������
filePath = 'E:\ѧϰ�ļ�\��ģ\��ѵ\ģ����\ģ����4\��������';
fileName = '����һ���ѽ�����Ŀ��������.xls';
[num, txt, raw] = xlsread([filePath, '\', fileName]);
close all;
%��ȡ��Ч����
len = length(num);
index0 = 1;
index1 = 1;
for i = 1:1:len
    if num(i, 4) == 0
        num0(index0, 1) = num(i, 1);
        num0(index0, 2) = num(i, 2);
%         num0(index0, 3) = num(i, 3);
        scores0(index0, 1) = num(i, 3);
        index0 = index0+1;
    elseif num(i, 4) == 1
        num1(index1, 1) = num(i, 1);
        num1(index1, 2) = num(i, 2);
%         num1(index1, 3) = num(i, 3);
        scores1(index1, 1) = num(i, 3);
        index1 = index1+1;
    end
end
figure;
plot3(num0(:, 1), num0(:, 2), scores0(:, 1), '.');
hold on;
plot3(num1(:, 1), num1(:, 2), scores1(:, 1), '.');
hold off;
grid on;
figure;
plot(num0(:, 1), num0(:, 2), '.');
hold on;
plot(num1(:, 1), num1(:, 2), '.');
hold off;
grid on;
title('��γ������');

% %��γ������ת��Ϊֱ������
% len0 = length(num0);
% len1 = length(num1); 
% cNum0 = zeros(len0, 2);
% cNum1 = zeros(len1, 2);
% for i = 1:1:len0
%     [cNum0(i, 1), cNum0(i, 2)] = LtoC(num0(i, 1), num0(i, 2));
% end
% for i = 1:1:len1
%     [cNum1(i, 1), cNum1(i, 2)] = LtoC(num1(i, 1), num1(i, 2));
% end
% figure;
% plot(cNum0(:, 1), cNum0(:, 2), '.');
% hold on;
% plot(cNum1(:, 1), cNum1(:, 2), '.');
% hold off;
% grid on;
% title('ֱ������');

%%
% cNum = [cNum0; cNum1];
% mu_x = mean(cNum(:, 1));
% mu_y = mean(cNum(:, 2));
% sigma_x = std(cNum(:, 1));
% sigma_y = std(cNum(:, 2));
% cNum0_std_x = (cNum0(:, 1)-mu_x)/sigma_x;
% cNum0_std_y = (cNum0(:, 2)-mu_y)/sigma_y;
% cNum0_std = [cNum0_std_x, cNum0_std_y];
% cNum1_std_x = (cNum1(:, 1)-mu_x)/sigma_x;
% cNum1_std_y = (cNum1(:, 2)-mu_y)/sigma_y;
% cNum1_std = [cNum1_std_x, cNum1_std_y];
% cNum0_std = zscore(cNum0);
% cNum1_std = zscore(cNum1);
% figure;
% plot(cNum0_std(:, 1), cNum0_std(:, 2), '.');
% hold on;
% plot(cNum1_std(:, 1), cNum1_std(:, 2), '.');
% hold off;
% grid on;
% title('ֱ�����꣨z-score��׼��)');

% scores = num(:, 3);
% x1 = cNum1_std(:, 1);
% x2 = cNum1_std(:, 2);
% X = [ones(size(scores1)), x1, x2, x1.^2, x2.^2, x1.*x2];
% [b,bint,r,rint,status] = regress(scores1, X);

%%
% Z=zscore(data1);%dataΪ��γ�����ݣ�����ת��֮��ľ�������ͬ��
eva = evalclusters(cNum1_std, 'kmeans', 'CalinskiHarabasz', 'KList', [1:10]);
%  ͨ��OptimalK�õ����ž�����k
 k = 2;
[idx,cmeans,sumD,D] = kmeans(cNum1_std, k, 'dist', 'sqEuclidean');
%idxÿ����Ķ�Ӧ�����ţ�cmeansΪk���������ĵ�λ�ã�
%sumDÿ�������е������ĵľ���ͣ�Dÿ���㵽�������ĵľ���

index1 = 1;
index2 = 1;
%��Ҫ����������ɢ��ͼ
for i = 1:1:length(cNum1_std)
    if idx(i) == 1
        cls1(index1, :) = cNum1_std(i, :);
        index1 = index1+1;
    elseif idx(i) == 2
        cls2(index2, :) = cNum1_std(i, :);
        index2 = index2+1;
    end
end
figure;
plot(cls1(:, 1), cls1(:, 2), '.');
hold on;
plot(cls2(:, 1), cls2(:, 2), '.');
hold off;
grid on;