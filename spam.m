function features = spam(image,K) 
%% creating Difference matrix 
 image=double(image);
 [M,N]=size(image);
 diffhorizontal1= image(:,1:N-1)-image(:,2:N);
 diffhorizontal2=image(:,2:N)-image(:,1:N-1);
 diffvertical1=image(1:M-1,:)-image(2:M,:);
 diffvertical2=image(2:M,:)-image(1:M-1,:);
 diffdiag1=image(2:M,1:N-1)-image(1:M-1,2:N);
 diffdiag2=image(1:M-1,2:N)-image(2:M,1:N-1);
 diffdiag3=image(1:M-1,1:N-1)-image(2:M,2:N);
 diffdiag4=image(2:M,2:N)-image(1:M-1,1:N-1);
 %% markov
T=K;
 markovhorizontal1=zeros((2*T+1),(2*T+1));
 markovhorizontal2=zeros((2*T+1),(2*T+1));
 markovvertical1=zeros((2*T+1),(2*T+1));
 markovvertical2=zeros((2*T+1),(2*T+1));
 markovdiag1=zeros((2*T+1),(2*T+1));
 markovdiag2=zeros((2*T+1),(2*T+1));
 markovdiag3=zeros((2*T+1),(2*T+1));
 markovdiag4=zeros((2*T+1),(2*T+1));
 T=T+1;
 for i=1:size(diffhorizontal1,1)
    for j=1:size(diffhorizontal1,2)-1
        if(diffhorizontal1(i,j)<T && diffhorizontal1(i,j)>-T && diffhorizontal1(i,j+1)>-T && diffhorizontal1(i,j+1)<T)
            markovhorizontal1(diffhorizontal1(i,j)+T,diffhorizontal1(i,j+1)+T)=markovhorizontal1(diffhorizontal1(i,j)+T,diffhorizontal1(i,j+1)+T)+1;
        end
    end
 end
  for i=1:size(diffhorizontal2,1)
    for j=1:size(diffhorizontal2,2)-1
        if(diffhorizontal2(i,j)<T && diffhorizontal2(i,j)>-T && diffhorizontal2(i,j+1)>-T && diffhorizontal2(i,j+1)<T)
            markovhorizontal2(diffhorizontal2(i,j+1)+T,diffhorizontal2(i,j)+T)=markovhorizontal2(diffhorizontal2(i,j)+T,diffhorizontal2(i,j+1)+T)+1;
        end
    end
  end
  for i=1:size(diffvertical1,1)-1
    for j=1:size(diffvertical1,2)
        if(diffvertical1(i,j)<T && diffvertical1(i,j)>-T && diffvertical1(i+1,j)>-T && diffvertical1(i+1,j)<T)
            markovvertical1(diffvertical1(i,j)+T,diffvertical1(i+1,j)+T)=markovvertical1(diffvertical1(i,j)+T,diffvertical1(i+1,j)+T)+1;
        end
         if(diffvertical2(i,j)<T && diffvertical2(i,j)>-T && diffvertical2(i+1,j)>-T && diffvertical2(i+1,j)<T)
            markovvertical2(diffvertical2(i+1,j)+T,diffvertical2(i,j)+T)=markovvertical2(diffvertical2(i+1,j)+T,diffvertical2(i,j)+T)+1;
        end
    end
  end
   for i=1:size(diffdiag1,1)-1
    for j=1:size(diffdiag1,2)-1
        if(diffdiag1(i,j)<T && diffdiag1(i,j)>-T && diffdiag1(i+1,j+1)>-T && diffdiag1(i+1,j+1)<T)
            markovdiag1(diffdiag1(i,j)+T,diffdiag1(i+1,j+1)+T)=markovdiag1(diffdiag1(i,j)+T,diffdiag1(i+1,j+1)+T)+1;
        end
         if(diffdiag2(i,j)<T && diffdiag2(i,j)>-T && diffdiag2(i+1,j+1)>-T && diffdiag2(i+1,j+1)<T)
            markovdiag2(diffdiag2(i+1,j+1)+T,diffdiag2(i,j)+T)=markovdiag2(diffdiag2(i+1,j+1)+T,diffdiag2(i,j)+T)+1;
        end
    end
  end
  for i=2:size(diffdiag3,1)
    for j=1:size(diffdiag3,2)-1
        if(diffdiag3(i,j)<T && diffdiag3(i,j)>-T && diffdiag3(i-1,j+1)>-T && diffdiag3(i-1,j+1)<T)
            markovdiag3(diffdiag3(i,j)+T,diffdiag3(i-1,j+1)+T)=markovdiag3(diffdiag3(i,j)+T,diffdiag3(i-1,j+1)+T)+1;
        end
         if(diffdiag4(i,j)<T && diffdiag4(i,j)>-T && diffdiag4(i-1,j+1)>-T && diffdiag4(i-1,j+1)<T)
            markovdiag4(diffdiag4(i-1,j+1)+T,diffdiag4(i,j)+T)=markovdiag4(diffdiag4(i-1,j+1)+T,diffdiag4(i,j)+T)+1;
        end
    end
  end
 %% feature vector generation
 markovhorizontal1=markovhorizontal1(:)/sum(markovhorizontal1(:));
 markovhorizontal2=markovhorizontal2(:)/sum(markovhorizontal2(:));
 markovvertical1=markovvertical1(:)/sum(markovvertical1(:));
 markovvertical2=markovvertical2(:)/sum(markovvertical2(:));
 markovdiag1=markovdiag1(:)/sum(markovdiag1(:));
 markovdiag2=markovdiag2(:)/sum(markovdiag2(:));
 markovdiag3=markovdiag3(:)/sum(markovdiag3(:));
 markovdiag4=markovdiag4(:)/sum(markovdiag4(:));
 fet1=(markovhorizontal1+markovhorizontal2+markovvertical1+markovvertical2)/4;
fet2=(markovdiag1+markovdiag2+markovdiag3+markovdiag4)/4;
%fet1=reshape(fet1,[],1);
%fet2=reshape(fet2,[],1);

features=zeros(2*((2*K+1)^2),1);
%%
features(1:(2*K+1)^2,1)=fet1(1:size(fet1),1);

features((2*K+1)^2+1:2*((2*K+1)^2),1)=fet2(1:size(fet2),1);


