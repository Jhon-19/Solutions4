clear;
clc;
<<<<<<< HEAD
% data_train= dlmread("datas_all.txt");
=======
%data_train= dlmread("datas_all.txt");
>>>>>>> 551715c8a31e0a62daf52a7939a9d58f5c2280d1
[num, txt, raw] = getDatas();
%disp(num);

format short
num_result = num (:,4);


num_train(:,1:3) = num(:,1:3);
num_test(:,1:3) = num(:,1:3) ;

%尝试将其改为true/fasle 两种取值
for i = 1:1:length(num)
    if(num_result(i) == 1)
        num_result(i) = true;
    else
        num_result(i) = false;
    end
end

%测试数据
num_test(:,3) = 70 ;
disp(num_result);
%disp(num_test);