boundary = 0.4667
for i= 1:1:length(y)
    if(y(i) > boundary)
        y(i) = 1;
        y1(i) = 1;
    else
        y(i) = 0;
        y1(i) = 0;
    end
end
number = 0;
for i= 1:1:length(y1)
    if(y(i) == t(i))
        number = number + 1;
    end
end
disp(["׼ȷ�ʣ�", number/length(y1)]);
disp(["ԭ������","���������"]);
data_all = [t',y'];
disp(data_all);

