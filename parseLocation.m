function [longitude, latitude] = parseLocation(str)
location = strsplit(str);
longitude = str2double(location{1, 1});
latitude = str2double(location{1, 2});
end