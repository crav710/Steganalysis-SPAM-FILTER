path_nonstegano='/home/ravi/Downloads/ProjectMS/NonStegoDifferent/';
% Database=dir(strcat(path_nonstegano,'*.pgm'));
Database=dir('*.pgm');
disp(length(Database));
total_image=length(Database);
%%
for i=1:total_image 
%     Img=imread(strcat(path_nonstegano,Database(i).name));
    Img=imread(Database(i).name);
    file_name=strcat('testnonstegojpg',int2str(i));
%     disp(file_name);
     imwrite(Img,[file_name '.jpg'],'Quality',100);
    
end
%%
