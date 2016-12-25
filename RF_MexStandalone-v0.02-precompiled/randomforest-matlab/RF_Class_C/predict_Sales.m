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
 load data/city30
 
% %twonorm, N=300, D=2
for j=1:10
	fprintf('%d,',j);
    for i=1:9
        
        % tic�������浱ǰʱ�䣬����ʹ��toc����¼�������ʱ�䡣
        % �����������ʹ�ã��÷����£�
        % tic
        % operations
	    tic;
	    model=classRF_train(smp55(1:55,1),lebel55x9(1:55,i),500);%���Ͻǵġ���ʾ���Ǿ����ת�á�
        total_train_time=toc; 
        toc
        tic;
	    y_hat(:,i) = classRF_predict(city30,model);
	    total_test_time=total_test_time+toc;	
        %length(x0)Ϊ���еĳ���,���������ж��ٸ�Ԫ��.���x0�Ǿ���Ļ�,�ȷ�˵M��N��,��ôlength����M��N�������������ֵ.
        %temp=length(find(y_hat~=label59))/length(label59);
        %keyboard
    end
end
fprintf('\nnum_tree %d: Avg train time %d, test time %d\n',1000,total_train_time/100,total_test_time/100);
for m=1:30
   predict_data=y_hat(m,:);
   [c1,c2]=sort(predict_data,'descend');
   
   sum=0;
   for x=1:9
       sum=c1(x)+sum;
   end
    for y=1:9
       c1(y)=c1(y)/sum;
    end
   c(2*m-1,:)=c2;
   c(2*m,:)=c1*100;
   % xlswrite('D:\smda\RF\RF_MexStandalone-v0.02-precompiled\randomforest-matlab\RF_Class_C\data\2016_12.xls',c2)
   xlswrite('D:\smda\RF\RF_MexStandalone-v0.02-precompiled\randomforest-matlab\RF_Class_C\data\city30.xlsx',c)
end



