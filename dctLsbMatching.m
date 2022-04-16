Database=dir('*.pgm');
disp(length(Database));
total_image=length(Database);


% A Standard Quantization Matrix
q_mtx =     [16 11 10 16 24 40 51 61; 
            12 12 14 19 26 58 60 55;
            14 13 16 24 40 57 69 56; 
            14 17 22 29 51 87 80 62;
            18 22 37 56 68 109 103 77;
            24 35 55 64 81 104 113 92;
            49 64 78 87 103 121 120 101;
            72 92 95 98 112 100 103 99];
random_seq=rand(200);


for i=1:200
    for j=1:200
       if random_seq(i,j)<0.5
           random_seq(i,j)=1;
       else
            random_seq(i,j)=0;
       end
    end
end

random_seq=reshape(random_seq,[40000,1]);


for i=1:total_image
    file_name = strcat(Database(i).name);
    %disp(Files(i).name);
    Img = imread(file_name);  
    [M,N]=size(Img);
    count=1;
    Img=floor(dct2(Img));
    for j=1:M
        for k=1:N
            pixel=Img(j,k);
            if pixel%2==0
                randcheck=rand(1);
                if random_seq(count)==0
                    Img(j,k)=Img(j,k);
                else
                    
                    if randcheck(1)>0.5
                    Img(j,k)=Img(j,k)+1;
                    else
                     Img(j,k)=Img(j,k)-1;
                    end
                        
                end
                
            elseif pixel==0
                if random_seq(count)==0
                    Img(j,k)=0;
                else
                    Img(j,k)=1;
                end
                
            elseif pixel==255
                if random_seq(count)==0
                    Img(j,k)=254;
                else
                    Img(j,k)=255;
                end   
                
            else
                randcheck=rand(1);
                
                if random_seq(count)==0
                    
                    if randcheck(1)>0.5
                    Img(j,k)=Img(j,k)+2;
                    else
                     Img(j,k)=Img(j,k);
                    end
                    
                else
                    Img(j,k)=Img(j,k);
                    
                end

                
            end
            count=count+1;
            if count<40000
                break
            end
            
        end
        
    end
    Inverse_Dct=idct2(Img);
    imwrite(Img,[file_name '.jpg'],'Quality',100);
    
    
end

