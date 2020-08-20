clear;
clc;
%读取用户的数据
filePath = 'E:\学习文件\数模\培训\模拟题\模拟题4\题设数据';
fileName = '附件二：会员信息数据.xlsx';
[num, txt, raw] = xlsread([filePath, '\', fileName]);
close all;
%提取所需会员数据
len = length(num)-1;
longitudes = zeros(len-2, 1);
latitudes = zeros(len-2, 1);
index = 1;
for i = 2:1:len
    [longitudes(index, 1), latitudes(index, 1)] = parseLocation(raw{i, 2});
    if longitudes(index, 1) > 100
        continue;
    end
    index = index+1;
end
location = [longitudes, latitudes];

%读取excel表任务点数据
filePath = 'E:\学习文件\数模\培训\模拟题\模拟题4\题设数据';
fileName = '附件一：已结束项目任务数据.xls';
num = xlsread([filePath, '\', fileName]);
close all;
% %提取有效数据
% len = length(num);
% index0 = 1;
% index1 = 1;
% for i = 1:1:len
%     if checkData([num(i, 1), num(i, 2)])
%         if num(i, 4) == 0
%             num0(index0, 1) = num(i, 1);
%             num0(index0, 2) = num(i, 2);
%     %         num0(index0, 3) = num(i, 3);
%             scores0(index0, 1) = num(i, 3);
%             index0 = index0+1;
%         elseif num(i, 4) == 1
%             num1(index1, 1) = num(i, 1);
%             num1(index1, 2) = num(i, 2);
%     %         num1(index1, 3) = num(i, 3);
%             scores1(index1, 1) = num(i, 3);
%             index1 = index1+1;
%         end
%     end
% end
%%

data1 = num(:, 1:1:2);
% eva = evalclusters(data1, 'kmeans', 'CalinskiHarabasz', 'KList', [1:10]);
k = 4;
[idx,cmeans,sumD,D] = kmeans(data1, k, 'dist', 'sqEuclidean');
index1 = 1;
index2 = 1;
index3 = 1;
index4 = 1;
for i = 1:1:length(num)
    if idx(i) == 1
        d1(index1, 1) = D(i, 1);
        num1(index1, 1) = num(i, 1);
        num1(index1, 2) = num(i, 2);
        scores1(index1, 1) = num(i, 3);
        index1 = index1+1;
    elseif idx(i) == 2
        d2(index2, 1) = D(i, 2);
        num2(index2, 1) = num(i, 1);
        num2(index2, 2) = num(i, 2);
        scores2(index2, 1) = num(i, 3);
        index2 = index2+1;
    elseif idx(i) == 3
        d3(index3, 1) = D(i, 3);
        num3(index3, 1) = num(i, 1);
        num3(index3, 2) = num(i, 2);
        scores3(index3, 1) = num(i, 3);
        index3 = index3+1;
    elseif idx(i) == 4
        d4(index4, 1) = D(i, 4);
        num4(index4, 1) = num(i, 1);
        num4(index4, 2) = num(i, 2);
        scores4(index4, 1) = num(i, 3);
        index4 = index4+1;
    end
end

x1 = d1(:, 1);
y1 = scores1(:, 1);
X = [ones(size(y1)), x1, x1.^2, x1.^3];
[b1,bint1,r1,rint1,status1] = regress(y1, X);
status1
disp(['第一类回归分析 : ', 'y1 = ', num2str(b1(1)), '+', num2str(b1(2)), '*x1+', ...
    num2str(b1(3)), '*x1^2+', num2str(b1(4)), '*x1^3']);

x2 = d2(:, 1);
y2 = scores2(:, 1);
X = [ones(size(y2)), x2, x2.^2, x2.^3];
[b2,bint2,r2,rint2,status2] = regress(y2, X);
status2
disp(['第二类回归分析 : ', 'y2 = ', num2str(b2(1)), '+', num2str(b2(2)), '*x2+', ...
    num2str(b2(3)), '*x2^2+', num2str(b2(4)), '*x2^3']);

x3 = d3(:, 1);
y3 = scores3(:, 1);
X = [ones(size(y3)), x3, x3.^2, x3.^3];
[b3,bint3,r3,rint3,status3] = regress(y3, X);
status3
disp(['第三类回归分析 : ', 'y3 = ', num2str(b3(1)), '+', num2str(b3(2)), '*x3+', ...
    num2str(b3(3)), '*x3^2+', num2str(b3(4)), '*x3^3']);

x4 = d1(:, 1);
y4 = scores1(:, 1);
X = [ones(size(y4)), x4, x4.^2, x4.^3];
[b4,bint4,r4,rint4,status4] = regress(y4, X);
status4
disp(['第四类回归分析 : ', 'y4 = ', num2str(b4(1)), '+', num2str(b4(2)), '*x4+', ...
    num2str(b4(3)), '*x4^2+', num2str(b4(4)), '*x4^3']);

%%
d1_point = zeros(length(num1), length(location));
for i = 1:1:length(num1)
    for j = 1:1:length(location)
        d1_point(i, j) = getDistance(num1(i, :), location(j, :));
    end
end

count1 = zeros(length(num1), 1);
for i = 1:1:length(num1)
    for j = 1:1:length(location)
        if d1_point(i, j) <= 2
            count1(i, 1) = count1(i, 1)+1;
        end
    end
end

d2_point = zeros(length(num2), length(location));
for i = 1:1:length(num2)
    for j = 1:1:length(location)
        d2_point(i, j) = getDistance(num2(i, :), location(j, :));
    end
end

count2 = zeros(length(num2), 1);
for i = 1:1:length(num2)
    for j = 1:1:length(location)
        if d2_point(i, j) <= 2
            count2(i, 1) = count2(i, 1)+1;
        end
    end
end

d3_point = zeros(length(num3), length(location));
for i = 1:1:length(num3)
    for j = 1:1:length(location)
        d3_point(i, j) = getDistance(num3(i, :), location(j, :));
    end
end

count3 = zeros(length(num3), 1);
for i = 1:1:length(num3)
    for j = 1:1:length(location)
        if d3_point(i, j) <= 2
            count3(i, 1) = count3(i, 1)+1;
        end
    end
end

d4_point = zeros(length(num4), length(location));
for i = 1:1:length(num4)
    for j = 1:1:length(location)
        d4_point(i, j) = getDistance(num4(i, :), location(j, :));
    end
end

count4 = zeros(length(num4), 1);
for i = 1:1:length(num4)
    for j = 1:1:length(location)
        if d4_point(i, j) <= 2
            count4(i, 1) = count4(i, 1)+1;
        end
    end
end

%%
x1 = count1(:, 1);
y1 = scores1(:, 1);
X = [ones(size(y1)), x1, x1.^2];
[b1,bint1,r1,rint1,status1] = regress(y1, X);
status1
disp(['第一类回归分析 : ', 'y1 = ', num2str(b1(1)), '+', num2str(b1(2)), '*x1+', ...
    num2str(b1(3)), '*x1^2']);

x2 = count2(:, 1);
y2 = scores2(:, 1);
X = [ones(size(y2)), x2, x2.^2];
[b2,bint2,r2,rint2,status2] = regress(y2, X);
status2
disp(['第二类回归分析 : ', 'y2 = ', num2str(b2(1)), '+', num2str(b2(2)), '*x2+', ...
    num2str(b2(3)), '*x2^2']);

x3 = count3(:, 1);
y3 = scores3(:, 1);
X = [ones(size(y3)), x3, x3.^2];
[b3,bint3,r3,rint3,status3] = regress(y3, X);
status3
disp(['第三类回归分析 : ', 'y3 = ', num2str(b3(1)), '+', num2str(b3(2)), '*x3+', ...
    num2str(b3(3)), '*x3^2']);

x4 = count1(:, 1);
y4 = scores1(:, 1);
X = [ones(size(y4)), x4, x4.^2];
[b4,bint4,r4,rint4,status4] = regress(y4, X);
status4
disp(['第四类回归分析 : ', 'y4 = ', num2str(b4(1)), '+', num2str(b4(2)), '*x4+', ...
    num2str(b4(3)), '*x4^2']);