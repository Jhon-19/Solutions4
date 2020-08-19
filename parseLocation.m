function [longitude, latitude] = parseLocation(str)
%解析含经纬度坐标的字符串
location = strsplit(str);
longitude = str2double(location{1, 1});
latitude = str2double(location{1, 2});
end