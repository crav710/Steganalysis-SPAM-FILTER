function [Z_Fda_l1,mean_0_l1,mean_1_l1,W_ans]=Fda_l1(Y,P,cl,imageCount)
p=P;
W_Fda=abs(randn(p,1));
nm=norm(W_Fda);
W_Fda=W_Fda/nm;

a=0.0001;

e=0.001;
classSize=cl;
Class1=Y(:,1:classSize);
Class2=Y(:,classSize+1:imageCount);
tp_class1=Class1';
tp_class2=Class2';
Mean_class1=(mean(tp_class1))';
Mean_class2=(mean(tp_class2))';

for lamda=1:10000
    
    
    check=W_Fda'*(Mean_class2-Mean_class1);
    
   if check>0
        delta=1;
    else 
        delta=-1;
    end
    check1=zeros(1,imageCount);
    res=zeros(1,imageCount);
    index=1;
   
    for i=1:classSize
        check1(:,index)=W_Fda'*(Class1(:,i)-Mean_class1);        
        index=index+1;
    end
    
    for i=1:classSize
        check1(:,index)=W_Fda'*(Class2(:,i)-Mean_class2);        
        index=index+1;
    end
    
    for i=1:imageCount
        if check1(1,i)>0
            res(1,i)=1;
        else
            res(1,i)=-1;
        end
    end
    
   numerator=zeros(p,1);
   denominator=0;
    for i=1:classSize
        numerator=numerator+res(1,i)*(Class1(:,i)-Mean_class1);
        denominator=denominator+abs(W_Fda'*(Class1(:,i)-Mean_class1));
    end
    
    for i=1:classSize
        numerator=numerator+res(1,i)*(Class2(:,i)-Mean_class2);
        denominator=denominator+abs(W_Fda'*(Class2(:,i)-Mean_class2));
    end
    
    
    Right_term=numerator/denominator;
    
    
    
    Left_term=((delta)*(Mean_class2-Mean_class1))/(abs(W_Fda'*(Mean_class2-Mean_class1)));
    
    
    W_ans=Left_term-Right_term;
    W_Fdanew=a*W_ans+W_Fda;
    check3=norm(W_Fdanew-W_Fda);
    if(check3<=e)
        break;
       
    end
    W_Fda=W_Fdanew;
    
end
%%
Z_Fda_l1=W_Fdanew'*Y(:,1:imageCount);






%figure

%plot(Z1_l1);

%figure 

%plot(Z2_l1);

mean_0_l1=zeros(1,1);
mean_1_l1=zeros(1,1);

class_1_size=classSize;
class_2_size=classSize;
k_sum_l1=0;
size_end=1;
for j=1:size_end
    for i=1:classSize
        k_sum_l1=k_sum_l1+Z_Fda_l1(j,i);
    end
    mean_0_l1(j,1)=(k_sum_l1/class_1_size);
    k_sum_l1=0;
end
for j=1:size_end
    for i=1+classSize:imageCount
        k_sum_l1=k_sum_l1+Z_Fda_l1(j,i);
    end
    mean_1_l1(j,1)=(k_sum_l1/class_2_size);
    k_sum_l1=0;
end
Z1=zeros(1,imageCount);
Z2=zeros(1,imageCount);

for i=1:imageCount
    Z1(:,i)=(Z_Fda_l1(:,i)-mean_0_l1);
end
for i=1:imageCount
    Z2(:,i)=(Z_Fda_l1(:,i)-mean_1_l1);
end




 
figure 


plot(Z1,'g');

figure

plot(Z2,'b');

end

% Corr_1_l1=zeros(1,30);
% Corr_2_l1=zeros(1,30);
% 
% for i=1:30
%     Corr_1_l1(:,i)=1-pdist2(mean_0',Z(:,i)','cosine');
%     Corr_2_l1(:,i)=1-pdist2(mean_1',Z(:,i)','cosine');
% end
% 
% predict_class=zeros(1,30);
% tpr_l1_fda=zeros(1,29);
% fpr_l1_fda=zeros(1,29);
% tpr_l2_fda=zeros(1,29);
% fpr_l2_fda=zeros(1,29);
% start =abs(mean_0_l1);
% finish=abs(mean_1_l1);
% checkkkkk=start:100:finish;
% con=1;
% for j=start:1000:finish
% 
%     for i=1:30
%        
%         if(Z_Fda_l1(1,i)>j)
%             predict_class(1,i)=0;
%         else
%             predict_class(1,i)=1;
%         end
%     end
%     
%     tpr_c=0;
%     fpr_c=0;
%     for i=1:15
%         if predict_class(1,i)<1
%             tpr_c=tpr_c+1;
%         end
%     end
%     for i=16:30
%         if predict_class(1,i)>0
%             fpr_c=fpr_c+1;
%         end
%     end
%     tpr_l1_fda(1,con)=(tpr_c)/15;
%     fpr_l1_fda(1,con)=(fpr_c)/15;  
%     tpr_c=0;
%     fpr_c=0;
%     for i=1:15
%         if predict_class(1,i)>0
%             fpr_c=fpr_c+1;
%         end
%     end
%     for i=16:30
%         if predict_class(1,i)<1
%             tpr_c=tpr_c+1;
%         end
%     end
%     
%     tpr_l2_fda(1,con)=(tpr_c)/15;
%     fpr_l2_fda(1,con)=(fpr_c)/15;  
%     con=con+1;
% end
% 
% figure 
% plot(tpr_l1_fda,fpr_l1_fda)
% 
% figure
% plot(tpr_l2_fda,fpr_l2_fda);
% 
% 






