%% Unsharp masking：
IM=imread('test3_corrupt.pgm'); 
I=IM;
IMSize=size(IM); 
IM=cast(IM,'int32');
t=zeros(IMSize(1)+2,IMSize(2)+2); 
t=cast(t,'int32');  
t(2:IMSize(1)+1,2:IMSize(2)+1) = IM;
t(:,1)=t(:,2);  
t(:,IMSize(2)+2)=t(:,IMSize(2)+1);
t(1,:)=t(2,:);  
t(IMSize(1)+2,:)=t(IMSize(1)+1,:);
A=1.0; 
for i=2:1:IMSize(1)+1
    for j=2:1:IMSize(2)+1  
    IM(i-1,j-1)=t(i,j)*A-(t(i,j)*(-8)+t(i,j-1)+t(i-1,j-1)+t(i-1,j)+t(i,j+1)+t(i+1,j)+t(i+1,j+1)+t(i+1,j-1)+t(i-1,j+1));
    end
end
IM=cast(IM,'uint8'); 
figure(1);
subplot(1,2,1) 
imshow(I);  
title('原图像');
subplot(1,2,2) 
imshow(IM); 
title('usharp masking');

%% Sobel:
I=imread('test3_corrupt.pgm');
figure(2);
subplot(1,2,1);
imshow(I);
title('原图像');
[N,M]=size(I);
I=double(I);
h1=[-1,0,1;-2,0,2;-1,0,1];
h2=[-1,-2,-1;0,0,0;1,2,1];
Gx=conv2(I,h1,'same');
Gy=conv2(I,h2,'same');
F=abs(Gx)+abs(Gy);
for i=1:N
for j=1:M
    I(i,j)=F(i,j);
end
end
I=uint8(I);
subplot(1,2,2);
imshow(I);
title('Sobel');
%% Laplace:
I = imread('test3_corrupt.pgm'); 
[N,M]=size(I); 
figure(3);  
subplot(1,2,1); 
imshow(I); 
title('原图像'); 
t=ones(N,M); 
t=I; 
for i=2:N-1   
for j=2:M-1       
    I(i,j)=t(i+1,j)+t(i-1,j)+t(i,j+1)+t(i,j-1)-4*t(i,j);  
end
end
subplot(1,2,2); 
imshow(I); 
title('Laplace');
%% Canny:
I=imread('test3_corrupt.pgm'); 
figure(4);
subplot(1,2,1);
imshow(I);
title('原图像'); 
I1=edge(I,'canny');
subplot(1,2,2);
imshow(I1);
title('Canny');