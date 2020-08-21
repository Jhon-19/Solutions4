clear;
clc;
data_xy= dlmread("datas_all.txt");
[num, txt, raw] = getDatas();
x = data_xy(:,1);
y = data_xy(:,2);
price = num(:,3);
is_done = num(:,4);

%price verse is_done 
a = corrcoef(is_done, price);
disp(a);

[c,s] = wavedec2(data_xy, 2, "db1");
disp(c);
disp([thr,sorh,keepapp]);
%xd = wdencmp('lvd',data_xy,'db3',2,thr,sorh,keepapp);
%plot(xd);


