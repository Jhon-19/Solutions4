clear;
clc;
%��ȡ�û�������
filePath = 'E:\ѧϰ�ļ�\��ģ\��ѵ\ģ����\ģ����4\��������';
fileName = '����������Ա��Ϣ����.xlsx';
[num, txt, raw] = xlsread([filePath, '\', fileName]);
close all;
%��ȡ�����Ա����
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

%��ȡexcel�����������
filePath = 'E:\ѧϰ�ļ�\��ģ\��ѵ\ģ����\ģ����4\��������';
fileName = '����һ���ѽ�����Ŀ�������� - ����.xls';
num = xlsread([filePath, '\', fileName]);
close all;

%% �������
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
        scores1(index1, 1) = num(i, 5);
        index1 = index1+1;
    elseif idx(i) == 2
        d2(index2, 1) = D(i, 2);
        num2(index2, 1) = num(i, 1);
        num2(index2, 2) = num(i, 2);
        scores2(index2, 1) = num(i, 5);
        index2 = index2+1;
    elseif idx(i) == 3
        d3(index3, 1) = D(i, 3);
        num3(index3, 1) = num(i, 1);
        num3(index3, 2) = num(i, 2);
        scores3(index3, 1) = num(i, 5);
        index3 = index3+1;
    elseif idx(i) == 4
        d4(index4, 1) = D(i, 4);
        num4(index4, 1) = num(i, 1);
        num4(index4, 2) = num(i, 2);
        scores4(index4, 1) = num(i, 5);
        index4 = index4+1;
    end
end

%% �����������ľ���
scores = zeros(length(num), 1);
d_point = zeros(length(num), length(num));
for i = 1:1:length(num)
    for j = 1:1:length(num)
        d_point(i, j) = getDistance(num(i, 1:1:2), num(j, 1:1:2));
    end
    scores(i, 1) = num(i, 6);
end

%���
isPacked = zeros(length(num), 2);
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
        if minAct < 0.1 && minAct > 0
            isPacked(i, 1) = 1;
            isPacked(index, 1) = 1;
            isPacked(i, 2) = index;
            isPacked(index, 2) = i;
        end
    end
end

len = sum(isPacked(:, 1));
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
title('����������ֲ�ͼ');
xlabel('����/��');
ylabel('γ��/��');
legend('�����', 'δ�����');

%% ��ô�������Ͷ��۷���
index = 1;
packages = [0, 0;
                  0, 0];
for i = 1:1:length(isPacked)
    if isPacked(i, 2) ~= 0
        isSole = 1;
        for j = 1:1:length(packages)
            if i == packages(j, 2)
                isSole = 0;
                break;
            end
        end
        if isSole
            packages(index, 1) = i;
            packages(index, 2) = isPacked(i, 2);
            index = index+1;
        end
    end
end

%% ����۸�
packagesScore = zeros(length(packages), 1);
num_new = zeros(length(packages), 2);
for i = 1:1:length(packages)
    packagesScore(i, 1) = round(2*0.92*(scores(packages(i, 1))+scores(packages(i, 2))))/2;
    num_new(i, :) = 1/2*[num(packages(i, 1), 1)+num(packages(i, 2), 1),...
        num(packages(i, 1), 2)+num(packages(i, 2), 2)];
end

%% ȥ�������ľ�γ��
num_all = zeros(length(num)-2*length(packages), 3);
index = 1;
for i = 1:1:length(num)
    isExist = 0;
    for j = 1:1:length(packages)
        if i == packages(j, 1) || i == packages(j, 2)
            isExist = 1;
            break;
        end
    end
    if ~isExist
        num_all(index, 1:1:2) = num(i, 1:1:2);
        num_all(index, 3) = num(i, 6);
        index = index+1;
    end
end