%**************************************************************
%* Test of mex interface to Andy Liaw et al.'s C code (used in R package randomForest)
%* Added by Abhishek Jaiantilal ( abhishek.jaiantilal@colorado.edu )
%* License: GPLv2
%* Version: 0.02
%
%  This file runs tests about 10 times on the diabetes dataset
%
%**************************************************************

%compile everything
if strcmpi(computer,'PCWIN') |strcmpi(computer,'PCWIN64')
   compile_windows
else
   compile_linux
end  
 
clear;
clc

load data/label55x9
load data/smp55

%diabetes, N=442, D=10
total_train_time=0;
total_test_time=0;
for i=1:10
	fprintf('%d,',i);
    for j=1:9
	    tic;
	    model=regRF_train(smp55,lebel55x9(:,j),1000);
	    total_train_time=toc;
	    tic;
	    y_hat(:,j) =regRF_predict(smp55,model);
	    total_test_time=total_test_time+toc;	
    end
end
fprintf('\nnum_tree %d: Avg train time %d, test time %d\n',1000,total_train_time/100,total_test_time/100);

%diabetes, N=442, D=64
%this second version of the diabetes dataset has 64 dimensions rather than
%10
% total_train_time=0;
% total_test_time=0;
% for i=1:1
% 	fprintf('%d,',i);
% 	tic;
% 	model=regRF_train(diabetes.x2,diabetes.y,1000);
% 	total_train_time=total_train_time+toc;
% 	tic;
% 	y_hat =regRF_predict(diabetes.x2,model);
% 	total_test_time=total_test_time+toc;	
% end
% fprintf('\nnum_tree %d: Avg train time %d, test time %d\n',1000,total_train_time/100,total_test_time/100);
