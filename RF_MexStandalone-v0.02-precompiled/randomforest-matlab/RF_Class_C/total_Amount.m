%run plethora of tests

%compile everything
if strcmpi(computer,'PCWIN') |strcmpi(computer,'PCWIN64')
   compile_windows
else
   compile_linux
end

total_train_time=0;
total_test_time=0;

% 

 load data/label59
 load data/sam59
 
% %twonorm, N=300, D=2
for i=1:10
	fprintf('%d,',i);
    % tic用来保存当前时间，而后使用toc来记录程序完成时间。
    % 两者往往结合使用，用法如下：
    % tic
    % operations
	tic;
	model=classRF_train(sam59(1:52,:),label59(1:52,:),1500);%右上角的‘表示的是矩阵的转置。
    total_train_time=toc; 
    toc
    tic;
	y_hat = classRF_predict(sam59(53:59,:),model);
	total_test_time=total_test_time+toc;	
    %length(x0)为数列的长度,即它里面有多少个元素.如果x0是矩阵的话,比方说M行N列,那么length返回M和N这两个数的最大值.
%     temp=length(find(y_hat~=label59))/length(label59);
    %keyboard
end
fprintf('\nnum_tree %d: Avg train time %d, test time %d\n',1000,total_train_time/100,total_test_time/100);


