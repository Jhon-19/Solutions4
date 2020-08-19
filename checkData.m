function isPossible = checkData(data)
if data(1, 1) >= 22 && data(1, 1) <= 24 && data(1, 2) >= 112.5 && data(1, 2) <= 114.5
    isPossible = 1;
else
    isPossible = 0;
end
end