clear;
clc;
%��ȡexcel�����������
filePath = 'E:\ѧϰ�ļ�\��ģ\��ѵ\ģ����\ģ����4\��������';
fileName = '����һ���ѽ�����Ŀ��������.xls';
num = xlsread([filePath, '\', fileName]);
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

%%
data1 = [num0; num1];
% Z=zscore(data1);%dataΪ��γ�����ݣ�����ת��֮��ľ�������ͬ��
eva = evalclusters(data1, 'kmeans', 'CalinskiHarabasz', 'KList', [1:10]);
%  ͨ��OptimalK�õ����ž�����k
 k = 2;
[idx,cmeans,sumD,D] = kmeans(data1, k, 'dist', 'sqEuclidean');
%idxÿ����Ķ�Ӧ�����ţ�cmeansΪk���������ĵ�λ�ã�
%sumDÿ�������е������ĵľ���ͣ�Dÿ���㵽�������ĵľ���

%% ����������ɢ��ͼ
index1 = 1;
index2 = 1;
for i = 1:1:length(num0)
    if idx(i) == 1
        cls1_0(index1, :) = num0(i, :);
        index1 = index1+1;
    elseif idx(i) == 2
        cls2_0(index2, :) = num0(i, :);
        index2 = index2+1;
    end
end
figure;
plot(cls1_0(:, 1), cls1_0(:, 2), 'xb');
hold on;
plot(cls2_0(:, 1), cls2_0(:, 2), 'xy');
hold on;

index1 = 1;
index2 = 1;
for i = 1:1:length(num1)
    if idx(i+length(num0)) == 1
        cls1_1(index1, :) = num1(i, :);
        index1 = index1+1;
    elseif idx(i+length(num0)) == 2
        cls2_1(index2, :) = num1(i, :);
        index2 = index2+1;
    end
end
plot(cls1_1(:, 1), cls1_1(:, 2), '.g');
hold on;
plot(cls2_1(:, 1), cls2_1(:, 2), '.r');
hold on;

for i = 1:1:10
    drawCircle(cmeans(1, 1), cmeans(1, 2), i*0.05);
    drawCircle(cmeans(2, 1), cmeans(2, 2), i*0.05);
end
hold on; 

%��ȡ�û�������
filePath = 'E:\ѧϰ�ļ�\��ģ\��ѵ\ģ����\ģ����4\��������';
fileName = '����������Ա��Ϣ����.xlsx';
[num, txt, raw] = xlsread([filePath, '\', fileName]);
% close all;
%��ȡ��������
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
plot(longitudes, latitudes, 'om');

%��עͼ��
hold off;
grid on;
xlabel('����/��');
ylabel('γ��/��');
legend('δ��������1', 'δ��������2', '����������1', '����������2', '��Ա�ֲ�');
title('ȫ����������ͼ');

%% ��ÿ����ع����
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
z = zscore(cls1_0);
x1 = z(:, 1);
x2 = z(:, 2);
X = [ones(size(scores_cls1)), x1, x2, x1.^2, x2.^2, x1.*x2];
[b1,bint1,r1,rint1,status1] = regress(scores_cls1, X);
disp(['��һ����ع����: scores = ', num2str(b1(1)), '+', num2str(b1(2)), '*x1+', num2str(b1(3)), '*x2+' ...
    num2str(b1(4)), '*x1^2+', num2str(b1(5)), '*x2^2+', num2str(b1(6)), '*x1*x2']);
disp(['p1 = ', num2str(status1(3))]);

z = zscore(cls2_0);
x1 = z(:, 1);
x2 = z(:, 2);
X = [ones(size(scores_cls2)), x1, x2, x1.^2, x2.^2, x1.*x2];
[b2,bint2,r2,rint2,status2] = regress(scores_cls2, X);
disp(['�ڶ�����ع����: scores = ', num2str(b2(1)), '+', num2str(b2(2)), '*x1+', num2str(b2(3)), '*x2+' ...
    num2str(b2(4)), '*x1^2+', num2str(b2(5)), '*x2^2+', num2str(b2(6)), '*x1*x2']);
disp(['p2 = ', num2str(status2(3))]);
