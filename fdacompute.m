function [Y,mean_0,mean_1,Up,W]=fdacompute(Sample_all,image_count,P,classSize,t,Label,check)
% computiing the mean
T=t;
str=' ';
str1='FirstOrder';
str2='SecondOrder';
if check==0
    total_feature=((2*T+1)^2)*2;
    str=strcat(str,str1);
else
    total_feature=(((2*T+1)^3))*2;
    str=strcat(str,str2);
end
    
mean=zeros(total_feature,1);
total_image=image_count;
for i=1:total_image
   mean=mean+Sample_all(:,i);
end
mean=mean/total_image;

%subtracting mean

for i=1:total_image
    Sample_all(:,i)=Sample_all(:,i)-mean;
end


% Computing Covariance Matrix

Sample_transpose=transpose(Sample_all);
%Covariance=X_image*X_image_transpose;

[U,S,V]=svd(Sample_transpose*Sample_all);

% U,Up,Y 
U=Sample_all*U;
p=P;
Up=U(:,1:p);
Y=Up'*Sample_all;
% FDA computation

disp(size(Up));
[Z,W]=FDA(Y,Label',1);
disp(size(Z));
disp(size(W));

mean_0=zeros(1,1);
mean_1=zeros(1,1);
class_1_size=classSize;
class_2_size=classSize;
k_sum=0;
for j=1:1
    for i=1:class_1_size
        k_sum=k_sum+Z(j,i);
    end
    mean_0(j,1)=(k_sum/class_1_size);
    k_sum=0;
end
for j=1:1
    for i=class_1_size+1:class_1_size+class_2_size
        k_sum=k_sum+Z(j,i);
    end
    mean_1(j,1)=(k_sum/class_2_size);
    k_sum=0;
end


% calculating correlation 

Z1=zeros(1,image_count);
Z2=zeros(1,image_count);

for i=1:class_1_size*2
    Z1(:,i)=abs(Z(:,i)-mean_0);
end
for i=1:class_2_size*2
    Z2(:,i)=abs(Z(:,i)-mean_1);
end




 %%
figure 
plot(Z1,'g');
disp(str);
title(strcat('FDA Classifier ',str));
xlabel('Correlation ');
ylabel('Images');
%%
figure
plot(Z2,'b');
title(strcat('FDA Classifier ',str))
xlabel('Correlation ')
ylabel('Images')

end