function [longitude, latitude] = parseLocation(str)
%��������γ��������ַ���
location = strsplit(str);
longitude = str2double(location{1, 1});
latitude = str2double(location{1, 2});
end