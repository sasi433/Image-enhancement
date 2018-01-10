clc;
clear all;
close all;
load mandrill;

figure,imshow(mat2gray(X));
xij=(1:480)-240.5;
yij=(1:480)-240.5;
R0=305;
for i=1:480
    for j=1:480
        rij(i,j)=sqrt((xij(i))^2+(yij(j))^2);
        t(i,j)= atan2(yij(j),xij(i));
        r(i,j)=abs((R0*sin(rij(i,j)/R0)));
        x(i,j)=ceil(r(i,j)*cos(t(i,j)));    
        y(i,j)=ceil(r(i,j)*sin(t(i,j)));
    end
end
x=x-min(min(x))+1;
y=y-min(min(y))+1;
% % 
 new=ones(max(max(x)));
for i=1:480
for j=1:480
    new(x(i,j),y(i,j))=X(i,j);
end
end
 figure,imshow(mat2gray(new));
 title('warped image');