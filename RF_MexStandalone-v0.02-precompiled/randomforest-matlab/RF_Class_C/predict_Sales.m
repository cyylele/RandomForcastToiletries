%run plethora of tests

%compile everything
if strcmpi(computer,'PCWIN') |strcmpi(computer,'PCWIN64')
   compile_windows
else
   compile_linux
end

clear;
clc;

total_train_time=0;
total_test_time=0;

% 

 load data/label55x9
 load data/smp55
 
% %twonorm, N=300, D=2
for j=1:10
	fprintf('%d,',j);
    for i=1:9
        
        % tic用来保存当前时间，而后使用toc来记录程序完成时间。
        % 两者往往结合使用，用法如下：
        % tic
        % operations
	    tic;
	    model=classRF_train(smp55(1:55,:),lebel55x9(1:55,i),500);%右上角的‘表示的是矩阵的转置。
        total_train_time=toc; 
        toc
        tic;
	    y_hat(:,i) = classRF_predict(smp55(56:57,:),model);
	    total_test_time=total_test_time+toc;	
        %length(x0)为数列的长度,即它里面有多少个元素.如果x0是矩阵的话,比方说M行N列,那么length返回M和N这两个数的最大值.
        %temp=length(find(y_hat~=label59))/length(label59);
        %keyboard
    end
end
fprintf('\nnum_tree %d: Avg train time %d, test time %d\n',1000,total_train_time/100,total_test_time/100);


