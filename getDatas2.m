clear;
clc;
%读取excel表任务点数据
filePath = 'E:\学习文件\数模\培训\模拟题\模拟题4\题设数据';
fileName = '附件一：已结束项目任务数据.xls';
[num, txt, raw] = xlsread([filePath, '\', fileName]);
close all;
%提取有效数据
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
title('经纬度坐标');

%%
data1 = [num0; num1];
% Z=zscore(data1);%data为经纬度数据（坐标转换之后的聚类数不同）
eva = evalclusters(data1, 'kmeans', 'CalinskiHarabasz', 'KList', [1:10]);
%  通过OptimalK得到最优聚类数k
 k = 2;
[idx,cmeans,sumD,D] = kmeans(data1, k, 'dist', 'sqEuclidean');
%idx每个点的对应聚类编号，cmeans为k个聚类质心的位置，
%sumD每个类所有点与质心的距离和；D每个点到所有质心的距离

index1 = 1;
index2 = 1;
%需要画出聚类后的散点图
for i = 1:1:length(data1)
    if idx(i) == 1
        cls1(index1, :) = data1(i, :);
        index1 = index1+1;
    elseif idx(i) == 2
        cls2(index2, :) = data1(i, :);
        index2 = index2+1;
    end
end
figure;
plot(cls1(:, 1), cls1(:, 2), '.');
hold on;
plot(cls2(:, 1), cls2(:, 2), '.');
hold off;
grid on;
xlabel('经度');
ylabel('纬度');
title('全部任务点聚类图');

%%对每个类回归分析
index1 = 1;
index2 = 1;
scores = [scores0; scores1];
for i = 1:1:length(scores)
     if idx(i) == 1
        scores_cls1(index1, :) = scores(i, 1);
        index1 = index1+1;
    elseif idx(i) == 2
        scores_cls2(index2, :) = scores(i, 1);
        index2 = index2+1;
     end
end
z = zscore(cls1);
x1 = z(:, 1);
x2 = z(:, 2);
X = [ones(size(scores_cls1)), x1, x2, x1.^2, x2.^2, x1.*x2];
[b1,bint1,r1,rint1,status1] = regress(scores_cls1, X);
disp(['第一个类回归分析: scores = ', num2str(b1(1)), '+', num2str(b1(2)), '*x1+', num2str(b1(3)), '*x2+' ...
    num2str(b1(4)), '*x1^2+', num2str(b1(5)), '*x2^2+', num2str(b1(6)), '*x1*x2']);
disp(['p1 = ', num2str(status1(3))]);

z = zscore(cls2);
x1 = z(:, 1);
x2 = z(:, 2);
X = [ones(size(scores_cls2)), x1, x2, x1.^2, x2.^2, x1.*x2];
[b2,bint2,r2,rint2,status2] = regress(scores_cls2, X);
disp(['第二个类回归分析: scores = ', num2str(b2(1)), '+', num2str(b2(2)), '*x1+', num2str(b2(3)), '*x2+' ...
    num2str(b2(4)), '*x1^2+', num2str(b2(5)), '*x2^2+', num2str(b2(6)), '*x1*x2']);
disp(['p2 = ', num2str(status2(3))]);
