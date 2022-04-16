function yt=LDA(Class_1,Class_2,class_test,label)

data_SET=[Class_1,Class_2];
data_test=class_test;
[pcdat,dat]=matlabPCA(data_SET,2);
Modelinear = fitcdiscr(pcdat',label');
[p_test,dat_1]=matlabPCA(data_test,2);

yt=predict(Modelinear,p_test');
% 
% p=186;
% en=700;
% sum1=0;
% for f=1: p
%     if yt(f,1)==1
%         sum1=sum1+1;
%     end
%     %sum=sum+yt(f,1);
% end
% sum1=p-sum1;
% sum2=0;
% %sum=0;
% % for f=p+1: en
% %     if yt(f,1)==1
% %         sum2=sum2+1;
% %     end
% % sum=sum+yt(f,1);
% % end
% an=sum1+sum2;
% div=p;
% Accuracy=(an)/div;

figure
ylim([-0.5,2]);

stem(yt);



end