clear;
clc;
filePath = 'C:\Users\user\Desktop\数模\2020数模训练\4\第四次模拟题\第四次模拟题';
fileName = '附件二：会员信息数据.xlsx';
[num, txt, raw] = xlsread([filePath, '\', fileName]);
close all;
len = length(num)-1;
longitudes = zeros(len-1, 1);
latitudes = zeros(len-1, 1);
for i = 2:1:len
    [longitudes(i-1, 1), latitudes(i-1, 1)] = parseLocation(raw{i, 2});
    if longitudes(i-1, 1) > 100
%         disp(i-1);
        temp = longitudes(i-1, 1);
        longitudes(i-1, 1) = latitudes(i-1, 1);
        latitudes(i-1, 1) = temp;
    end
end
figure;
plot(longitudes, latitudes, '.');
grid on;