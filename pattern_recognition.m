%
% This script assumes these variables are defined:
%
%   num_train - input data.
%   num_result - target data.

%输入的变量
x = num_train';
%输入的结果
t = num_result';
%测试的输入
x1 = num_test';



% Choose a Training Function
% For a list of all training functions type: help nntrain
% 'trainlm' is usually fastest.
% 'trainbr' takes longer but may be better for challenging problems.
% 'trainscg' uses less memory. Suitable in low memory situations.
%trainFcn = 'trainscg';  % Scaled conjugate gradient backpropagation.

% Create a Pattern Recognition Network
hiddenLayerSize = 100;
net = patternnet(hiddenLayerSize, trainFcn);
net.layers{1}.transferFcn = 'logsig';  %将激活函数改为sigmod
net.trainFcn = 'traincgf'; 

% Setup Division of Data for Training, Validation, Testing
net.divideParam.trainRatio = 70/100;
net.divideParam.valRatio = 15/100;
net.divideParam.testRatio = 15/100;

% Train the Network
[net,tr] = train(net,x,t);

% Test the Network
%对原数据模式识别结果
y = net(x);
val = sim(net,x);
val_result = vec2ind(val); 

 %计算正确率
r = sum(val_result == t)/(length(y)); 
disp(['模式识别的正确率为',num2str(r)]);  





e = gsubtract(t,y);
performance = perform(net,t,y)
tind = vec2ind(t);
yind = vec2ind(y);;
percentErrors = sum(tind ~= yind)/numel(tind);


% View the Network
%view(net)

% Plots
% Uncomment these lines to enable various plots.
%figure, plotperform(tr)
%figure, plottrainstate(tr)
%figure, ploterrhist(e)
%figure, plotconfusion(t,y)
%figure, plotroc(t,y)

