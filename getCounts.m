clear;
clc;
filePath = 'C:\Users\user\Desktop\��ģ\2020��ģѵ��\4\���Ĵ�ģ����\���Ĵ�ģ����';
fileName = '����������Ա��Ϣ����.xlsx';
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