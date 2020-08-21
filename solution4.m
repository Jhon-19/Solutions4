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
fileName = '附件三：新项目任务数据.xls';
num = xlsread([filePath, '\', fileName]);
close all;
figure;
plot(num(:, 1), num(:, 2), '.');
grid on;
title('新任务分布图');
xlabel('经度/°');
ylabel('纬度/°');

%% 聚类分析
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
        num1(index1, :) = num(i, :);
        index1 = index1+1;
    elseif idx(i) == 2
        d2(index2, 1) = D(i, 2);       
        num2(index2, :) = num(i, :);
        index2 = index2+1;
    elseif idx(i) == 3
        d3(index3, 1) = D(i, 3);       
        num3(index3, :) = num(i, :);
        index3 = index3+1;
    elseif idx(i) == 4
        d4(index4, 1) = D(i, 4);       
        num4(index4, :) = num(i, :);
        index4 = index4+1;
    end
end

%% 会员数量的计算
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

%引用第二问的定价模型
ss = 1.0e+03*[ 0.067134906547233, 0.068635245895575, 0.067499062763727, 0.067134906547233;
               0.034343665144235, 0.037598763863261, 0.121371320900556, 0.034343665144235;
               0.023949107998428, 0.046537324746500, -1.174324573371970, 0.023949107998428;
               1.097232248756462, -0.352667931535862, 5.907969268123837, 1.097232248756462];
ns = [78.960246476307276, 74.388692159002133, 73.900496260424845, 78.960246476307276;
      -0.794911872842428, -0.360647200425248, -0.183680644106105, -0.794911872842428;
       0.011807863766947, 0.001096376990613, -0.015771459988584, 0.011807863766947];
           
%% 计算定价
price_new1 = getPrice(ss(:, 1), ns(:, 1), d1, count1);
price_new2 = getPrice(ss(:, 2), ns(:, 2), d2, count2);
price_new3 = getPrice(ss(:, 3), ns(:, 3), d3, count3);
price_new4 = getPrice(ss(:, 4), ns(:, 4), d4, count4);

price_new1 = round(price_new1*2)/2;
price_new2 = round(price_new2*2)/2;
price_new3 = round(price_new3*2)/2;
price_new4 = round(price_new4*2)/2;

price_new = zeros(length(num), 1);
index1 = 1;
index2 = 1;
index3 = 1;
index4 = 1;
for i = 1:1:length(num)
    if idx(i) == 1
        price_new(i, 1) = price_new1(index1, 1);
        index1 = index1+1;
    elseif idx(i) == 2
        price_new(i, 1) = price_new2(index2, 1);
        index2 = index2+1;
    elseif idx(i) == 3
        price_new(i, 1) = price_new3(index3, 1);
        index3 = index3+1;
    elseif idx(i) == 4
        price_new(i, 1) = price_new4(index4, 1);
        index4 = index4+1;
    end
end

%% 打包
scores = zeros(length(num), 1);
d_point = zeros(length(num), length(num));
for i = 1:1:length(num)
    for j = 1:1:length(num)
        d_point(i, j) = getDistance(num(i, 1:1:2), num(j, 1:1:2));
    end
    scores(i, 1) = price_new(i, 1);
end

isPacked = zeros(length(num), 1);
for i = 1:1:length(num)
    minAct = 1;
    index = 0;
    if isPacked(i) == 0
        for j = 1:1:length(num)
            if isPacked(j) == 0
                if d_point(i, j) < 1.5 && j ~= i
                    thisAct = getAct(scores(i, 1), scores(j, 1), d_point(i, j));
                    if thisAct < minAct
                        minAct = thisAct;
                        index = j;
                    end
                end
            end
        end
        if minAct < 0.8 && minAct > 0
            isPacked(i, 1) = 1;
            isPacked(index, 1) = 1;
        end
    end
end

len = sum(isPacked);
num1 = zeros(len, 2);
num0 = zeros(length(num)-len, 2);
index1 = 1;
index0 = 1;
for i = 1:1:length(num)
    if isPacked(i) == 1
        num1(index1, :) = num(i, 1:1:2);
        index1 = index1+1;
    elseif isPacked(i) == 0
        num0(index0, :) = num(i, 1:1:2);
        index0 = index0+1;
    end
end

figure;
plot(num1(:, 1), num1(:, 2), '.');
hold on;
plot(num0(:, 1), num0(:, 2), '.');
hold off;
grid on;
title('打包后任务点分布图');
xlabel('经度/°');
ylabel('纬度/°');
legend('打包点', '未打包点');