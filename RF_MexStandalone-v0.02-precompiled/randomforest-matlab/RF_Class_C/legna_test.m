%% 基于随机森林思想的组合分类器设计

%% 清空环境变量
%clear all
clc
warning ('off');

%% 导入数据
load data.mat
% 随机产生训练集/测试集
a = randperm(569);%把1到569这些数随机打乱得到的一个数字序列。
Train = data(a(1:500),:);
Test = data(a(501:end),:);
% 训练数据
P_train = Train(:,3:end);
T_train = Train(:,2);
% 测试数据
P_test = Test(:,3:end);
T_test = Test(:,2);

%% 创建随机森林分类器
model = classRF_train(P_train,T_train);

%% 仿真测试
[T_sim,votes] = classRF_predict(P_test,model);