% path_stegano='/home/ravi/Downloads/ProjectMS/SteganographyImages/';
% path_nonstegano='/home/ravi/Downloads/ProjectMS/NonStegoSame/';
% path_test='/home/ravi/Downloads/ProjectMS/testImages/';
% path_nonstegoDiff='/home/ravi/Downloads/ProjectMS/NonStegoDifferentJPG/';
% path_stego_jpg='/home/ravi/Downloads/ProjectMS/Steganojpg/';
% path_nonstego_jpg='/home/ravi/Downloads/ProjectMS/NonStegoJpg/';
% Databasestegan=dir(strcat(path_stego_jpg,'*.jpg'));
% Databasenormal=dir(strcat(path_nonstegoDiff,'*.jpg'));
% TestDataBase=dir(strcat(path_test,'*.jpg'));
% disp(length(Databasestegan));
% total_imagestegan=length(Databasestegan);
% total_imagenormal=length(Databasenormal);
% total_testimage=length(TestDataBase);
% lsb=0;
% 
% 
% 
% T=5;
% dim=(((2*T+1)^2))*2;
% featurestegano=zeros(dim,total_imagestegan);
% featuresnonstegano=zeros(dim,total_imagenormal);
% dimension2=(((2*T+1)^3))*2;
% featuresteganosecondOrder=zeros(dimension2,total_imagestegan);
% featuresnonsteganosecondOrder=zeros(dimension2,total_imagenormal);
% disp('prasoon')
% testffo=zeros(dim,total_testimage);
% testfso=zeros(dimension2,total_testimage);
% %% feature calcultion starts here
% for i=1:total_testimage
%     file_name = strcat(path_test,TestDataBase(i).name);
%     %disp(Files(i).name);
%     Img = imread(file_name);  
%    
%     f=spam(Img,T);
%     f2=spam2(Img,T);
%     testffo(:,i)=f;
%     testfso(:,i)=f2;
% end
% 
% for i=1:total_imagestegan
%     file_name = strcat(path_stego_jpg,Databasestegan(i).name);
%     %disp(Files(i).name);
%     Img = imread(file_name);  
%    
%     f=spam(Img,T);
%     f2=spam2(Img,T);
%     featurestegano(:,i)=f;
%     featuresteganosecondOrder(:,i)=f2;
% end
% 
% for i=1:total_imagenormal
%     file_name = strcat(path_nonstegoDiff,Databasenormal(i).name);
%     %disp(Files(i).name)%             Commented feature actual feature
%                                                           calculation
%     Img = imread(file_name);  
%     f=spam(Img,T);
%     f2=spam2(Img,T);
%     featuresnonstegano(:,i)=f;
%     featuresnonsteganosecondOrder(:,i)=f2;
% end
% total_features=[featurestegano featuresnonstegano];
% total_featuresSecond=[featuresteganosecondOrder,featuresnonsteganosecondOrder];
%% feature calculation ends here    Accuracy values will accuracyfo, accuracyso for fda and svmacc , svmacc2 for svm
total_imagenormal=2000;
total_testimage=2000;
Label=zeros(1,2*total_imagenormal);
for i=1:total_imagestegan
    Label(1,i)=0;
end
for i=total_imagenormal+1:2*total_imagenormal
    Label(1,i)=1;
end
disp('section1');

total_features=rand(242,4000);
total_featuresSecond=randn(2662,4000);


[result,mean_0,mean_1,Up,W]=fdacompute(total_features,2*total_imagenormal,1200,total_imagenormal,T,Label,0);
  Ztestfo=Up'*testffo;
    Ztestfo=W'*Ztestfo;
rhofo=zeros(total_testimage,1);

    
rhoso=zeros(total_testimage,1);



accuracyfo=0;
for i=(total_testimage/2):total_testimage
    if(abs(Ztestfo(1,i)-mean_0)<abs(Ztestfo(1,i)-mean_1))
    accuracyfo=accuracyfo+1;
    end
   
  
   
    
end
    

[result_s,mean_0_sec,mean_1_sec,Up_s,W_s]=fdacompute(total_featuresSecond,2*total_imagenormal,1200,total_imagenormal,T,Label,1);
  Ztestso=Up_s'*testfso;
    Ztestso=W_s'*Ztestso;
   
    accuracyso=0;
    for i=total_testimage/2:total_testimage
      if(abs(Ztestso(1,i)-mean_0_sec)<=abs(Ztestso(1,i)-mean_1_sec))
    accuracyso=accuracyso+1;
      end
    end
     
    

svm=SVMcalculate(total_features,Label,testffo);
% accuracy
svmacc=0;
for i=total_testimage/2:total_testimage
    if svm(i)==0
        svmacc=svmacc+1;
       
    end
end

svm2=SVMcalculate(total_featuresSecond,Label,testfso);

svmacc2=0;
for i=total_testimage/2:total_testimage
    if svm2(i)==0
        svmacc2=svmacc2+1;
       
    end
end


% %% FDA L1 
% P=1200;
% [zl1,mean_0_l1,mean_1_l1,Wl1]=Fda_l1(result,P,total_imagenormal,2*total_imagenormal);
% 
% %%
%  Ztestfo=Up'*testffo;
%     Ztestfo=Wl1'*Ztestfo;
% rhofo=zeros(total_testimage,1);
% 
%     
% rhoso=zeros(total_testimage,1);
% %%
% accuracyfo=0;
% for i=(total_testimage/2):total_testimage
%     if((Ztestfo(1,i)-mean_0_l1)<(Ztestfo(1,i)-mean_1_l1))
%     accuracyfo=accuracyfo+1;
%     end
%    
%   
%    
%     
% end
 %%
%  
% fda_l12=Fda_l1(result_s,P,total_imagenormal,2*total_imagenormal);
% 
% Ztestso=Up_s'*testfso;
%     Ztestso=W_s'*Ztestso;
%     %%
%     accuracyso=0;
%     for i=total_testimage/2:total_testimage
%       if(abs(Ztestso(1,i)-mean_0_sec)<=abs(Ztestso(1,i)-mean_1_sec))
%     accuracyso=accuracyso+1;
%       end
%     end
%      
% %% LDA 
% 
% 
% predictedLDaModel=LDA(featurestegano,featuresnonstegano,testfo,Label);
% ldaacc=0;
% for i=total_testimage/2:total_testimage
%     if predictedLDaModel(i)==0
%         ldaacc=ldaacc+1;
%     end
% end
% 
% %%
% % testso=[testfso,testfso];
% %%
% predictedLDaModel2=LDA(featuresteganosecondOrder,featuresnonsteganosecondOrder,testso,Label);
% 
% ldaacc2=0;
% for i=total_testimage/2:total_testimage
%     if predictedLDaModel2(i)==0
%         ldaacc2=ldaacc2+1;
%     end
% end

%%







