%% PROJECT 
clc;
clear all;
close all;
load('Image58.mat');
I= mat2gray(IMAGE);
figure
imshow(I)
title('Input image')
%% Removal of noise

[J,noise]=wiener2(I,[3 3]);
figure
imshow(mat2gray(J));
title('Removal of noise from image');

%% Deblurring

N=21;
h5=fir1(N-1,0.7,'low',hamming(N));                                          
h51=ftrans2(h5);                                                           
figure
freqz2(h51);
D=inverseFilter(J,h51,1);
figure
imshow((D))
title('Deblurred image')

%% Unwarping image
xij=[1:380]-190.5;
yij=[1:380]-190.5;
for i=1:380
    for j=1:380
        rij(i,j)=sqrt((xij(i))^2+(yij(j))^2);
       teta(i,j)= atan2(yij(j),xij(i));
        r(i,j)=abs((R0*asin(rij(i,j)/R0)));
        x(i,j)=ceil(r(i,j)*cos(teta(i,j)));    
        y(i,j)=ceil(r(i,j)*sin(teta(i,j)));
    end
end
x=x+max(max(x));
y=y+max(max(y));

 Z=zeros(max(max(x)));
for i=1:380
for j=1:380
    Z(x(i,j),y(i,j))=D(i,j);
end
end
 figure,imshow(mat2gray(Z));
 title('unwarped image');
 G1=Z;
for i=2:length(Z)-1
   for j=2:length(Z)-1
       if Z(i,j)==0
           G1(i,j)=(G1(i+1,j)+G1(i-1,j)+G1(i,j+1)+G1(i,j-1)+G1(i+1,j+1)+G1(i-1,j-1)+G1(i+1,j-1)+G1(i-1,j+1))/7;
       end
           
   end
end
figure,
imshow(G1);
title('output Image');
% figure,imshow(mat2gray(new));
%  Z2=medfilt2(new,[3 3]);
%  Z3=medfilt2(Z2,[3 3]);
%  Z4=medfilt2(Z3,[3 3]);
% figure,imshow(mat2gray(Z4));
