%function foo=Lsb(image)
path_stegano='/home/ravi/Downloads/ProjectMS/SteganographyImages/';
path_nonstegano='/home/ravi/Downloads/ProjectMS/NonStegoSame/';
path_test='/home/ravi/Downloads/ProjectMS/testImages/';
path_nonstegoDiff='/home/ravi/Downloads/ProjectMS/NonStegoDifferent/';
% Database=dir(strcat(path_nonstegano,'*.pgm'));
Database=dir('*.pgm');
disp(length(Database));
total_image=length(Database);
% total_image=1;

i=1;
img_old=imread(Database(i).name);
[M1,N1]=size(img_old);
disp(M1);
disp(N1);
dimens=400;
%%



random_seq=rand(dimens);


for i=1:dimens
    for j=1:dimens
       if random_seq(i,j)<0.5
           random_seq(i,j)=1;
       else
            random_seq(i,j)=0;
       end
    end
end
random_seq=reshape(random_seq,[dimens*dimens,1]);

for i=1:total_image
    file_name = strcat(Database(i).name);
    %disp(Files(i).name);
%     Img = imread(strcat(path_nonstegano,file_name));  
    Img = imread(file_name);
    [M,N]=size(Img);
    count=1;
    flag=0;
    for j=1:M
        if(flag==1)
               break;
        end
        for k=1:N
            pixel=Img(j,k);
            if mod(pixel,2) == 0
                randcheck=rand(1);
                if random_seq(count,1)==0
                    Img(j,k)=Img(j,k);
                else
                    
                    if randcheck(1)>0.5
                    Img(j,k)=Img(j,k)+1;
                    else
                     Img(j,k)=Img(j,k)-1;
                    end
                        
                end
                
            elseif pixel==0
                if random_seq(count,1)==0
                    Img(j,k)=0;
                else
                    Img(j,k)=1;
                end
                
            elseif pixel==255
                if random_seq(count,1)==0
                    Img(j,k)=254;
                else
                    Img(j,k)=255;
                end   
                
            else
                randcheck=rand(1);
                
                if random_seq(count,1)==0
                    
                    if randcheck(1)>0.5
                    Img(j,k)=Img(j,k)+1;
                    else
                     Img(j,k)=Img(j,k)-1;
                    end
                    
                else
                    Img(j,k)=Img(j,k);
                    
                end

                
            end
            count=count+1;
            if count>=(dimens*dimens)
                flag=1;
                break;
            end
            
          end
        
        
    end
    file_name=strcat('teststegano',int2str(i));
%     disp(file_name);
     %imwrite(Img,[file_name '.jpg']);
    imwrite(Img,[file_name '.jpg'],'Quality',100);
    
    
imgn=img_old-Img;

    
end




