clear;
clc;
%读取用户的数据
filePath = 'E:\学习文件\数模\培训\模拟题\模拟题4\题设数据';
fileName = '附件二：会员信息数据.xlsx';
[num, txt, raw] = xlsread([filePath, '\', fileName]);
close all;
%提取所需数据
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
figure;
plot(longitudes, latitudes, '.');
grid on;
%经纬度坐标转直角坐标
cLon = zeros(len-2, 1);
cLat = zeros(len-2, 1);
for i = 1:1:len-2
    [cLon(i, 1), cLat(i, 1)] = LtoC(longitudes(i, 1), latitudes(i, 1));
end

figure;
plot(cLon, cLat, '.');
grid on;
