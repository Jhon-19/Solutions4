filePath = 'D:\user\����\QQ\QQ�����ļ�';
fileName = '������������Ŀ�������� - ����.xls';
[num, txt, raw] = xlsread([filePath, '\', fileName]);
disp(num);
y=net(num');
boundary = 0.4667;
for i= 1:1:length(y)
    if(y(i) > boundary)
        y(i) = 1;
       
    else
        y(i) = 0;
       
    end
end
y3=y';
disp(y3);