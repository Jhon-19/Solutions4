% This script assumes these variables are defined:
%
%   num_train - input data.
%   num_result - target data.

%输入的变量
x = num_train';
%输入的结果
t = num_result';
%测试的输入（需修改）
x1 = num_test';


% Choose a Training Function
% For a list of all training functions type: help nntrain
% 'trainlm' is usually fastest.
% 'trainbr' takes longer but may be better for challenging problems.
% 'trainscg' uses less memory. Suitable in low memory situations.
trainFcn = 'trainbr';  % Bayesian Regularization backpropagation.

% Create a Fitting Network
%运行慢可改为200/300
hiddenLayerSize = 500;
net = fitnet(hiddenLayerSize,trainFcn);

% Choose Input and Output Pre/Post-Processing Functions
% For a list of all processing functions type: help nnprocess
net.input.processFcns = {'removeconstantrows','mapminmax'};
net.output.processFcns = {'removeconstantrows','mapminmax'};

% Setup Division of Data for Training, Validation, Testing
% For a list of all data division functions type: help nndivision
net.divideFcn = 'dividerand';  % Divide data randomly
net.divideMode = 'sample';  % Divide up every sample
net.divideParam.trainRatio = 85/100;
net.divideParam.valRatio = 5/100;
net.divideParam.testRatio = 10/100;

% Choose a Performance Function
% For a list of all performance functions type: help nnperformance
net.performFcn = 'mse';  % Mean Squared Error

% Choose Plot Functions
% For a list of all plot functions type: help nnplot
net.plotFcns = {'plotperform','plottrainstate','ploterrhist', ...
    'plotregression', 'plotfit'};

% Train the Network
[net,tr] = train(net,x,t);

% Test the Network
y = net(x);
y1 = net(x1);
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

%输入数据以及测试数据 拟合后0 1标准化
%{
last_boundary = 0.4;
accuracy = 0;
boundary_accu_array =[];
for boundary = 0.4:0.00001:0.6

for i= 1:1:length(y)
    if(y(i) > boundary)
        y(i) = 1;
        y1(i) = 1;
    else
        y(i) = 0;
        y1(i) = 0;
    end
end

%正确率
number = 0;
for i= 1:1:length(y1)
    if(y1(i) == t(i))
        number = number + 1;
    end
end

disp(["boundary:",boundary]);
disp(["准确率：", number/length(y1)]);
if(number/length(y1)>accuracy)
    last_boundary = boundary;
    accuracy = number/length(y1);
end
boundary_accu_array=[boundary_accu_array;last_boundary,accuracy];
end
disp(["last_boundary:",last_boundary]);
disp(["准确率：", accuracy]);
%}

%{
str = ['原始完成情况','训练后对原数据的拟合','训练后对测试数据的拟合'];
all_data = [num_result,y',y1'];
disp([str;all_data]);
plot(x,y,'o');
plot(x,y,'-');
%}

%待测数据和结果
str = ['经度','纬度','任务标价','任务完成与否'];
disp(str);
data_test_all = [x1',y1'];
disp(data_test_all);


e = gsubtract(t,y);
performance = perform(net,t,y)

% Recalculate Training, Validation and Test Performance
trainTargets = t .* tr.trainMask{1};
valTargets = t .* tr.valMask{1};
testTargets = t .* tr.testMask{1};
trainPerformance = perform(net,trainTargets,y)
valPerformance = perform(net,valTargets,y)
testPerformance = perform(net,testTargets,y)

% View the Network
%view(net)

% Plots
% Uncomment these lines to enable various plots.
%figure, plotperform(tr)
%figure, plottrainstate(tr)
%figure, ploterrhist(e)
%figure, plotregression(t,y)
%figure, plotfit(net,x,t)

% Deployment
% Change the (false) values to (true) to enable the following code blocks.
% See the help for each generation function for more information.
if (false)
    % Generate MATLAB function for neural network for application
    % deployment in MATLAB scripts or with MATLAB Compiler and Builder
    % tools, or simply to examine the calculations your trained neural
    % network performs.
    genFunction(net,'myNeuralNetworkFunction');
    y = myNeuralNetworkFunction(x);
end
if (false)
    % Generate a matrix-only MATLAB function for neural network code
    % generation with MATLAB Coder tools.
    genFunction(net,'myNeuralNetworkFunction','MatrixOnly','yes');
    y = myNeuralNetworkFunction(x);
end
if (false)
    % Generate a Simulink diagram for simulation or deployment with.
    % Simulink Coder tools.
    gensim(net);
end
