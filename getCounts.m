clear;
clc;
%��ȡ�û�������
filePath = 'E:\ѧϰ�ļ�\��ģ\��ѵ\ģ����\ģ����4\��������';
fileName = '����������Ա��Ϣ����.xlsx';
[num, txt, raw] = xlsread([filePath, '\', fileName]);
close all;
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
figure;
plot(longitudes, latitudes, '.');
grid on;
%��γ������תֱ������
cLon = zeros(len-2, 1);
cLat = zeros(len-2, 1);
for i = 1:1:len-2
    [cLon(i, 1), cLat(i, 1)] = LtoC(longitudes(i, 1), latitudes(i, 1));
end

figure;
plot(cLon, cLat, '.');
grid on;
