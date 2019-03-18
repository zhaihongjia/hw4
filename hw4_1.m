%% 中值滤波
clear;clc;
[I,map]=imread('test2.tif');
figure(1);
subplot(2,2,1);
imshow(I,map);
title('原始图像');
[x,y]=size(I);
n1=3;
n2=5;
n3=7;
N1=ones(n1,n1);
N2=ones(n2,n2);
N3=ones(n3,n3);
x1=double(I);
x2=x1;
for i=2:x-1
    for j=2:y-1
        N1=[x1(i-1,j-1:j+1),x1(i+1,j-1:j+1)];
        N1=sort(N1);
        x2(i,j)=N1((n1*n1+1)/2);
    end
end
I2=uint8(x2);
subplot(2,2,2);
imshow(I2,map);
title('中值滤波（3x3）')
for i=3:x-2
    for j=3:y-2
        N2=[x1(i-2,j-2:j+2),x1(i-1,j-2:j+2),x1(i,j-2:j+2),x1(i+1,j-2:j+2),x1(i+2,j-2:j+2)];
        N2=sort(N2);
        x2(i,j)=N2((n2*n2+1)/2);
    end
end
I2=uint8(x2);
subplot(2,2,3);
imshow(I2,map);
title('中值滤波（5x5）')
for i=4:x-3
    for j=4:y-3
        N3=[x1(i-3,j-3:j+3),x1(i-2,j-3:j+3),x1(i-1,j-3:j+3),x1(i,j-3:j+3),x1(i+1,j-3:j+3),x1(i+2,j-3:j+3),x1(i+3,j-3:j+3)];
        N3=sort(N3);
        x2(i,j)=N3((n3*n3+1)/2);
    end
end
I2=uint8(x2);
subplot(2,2,4);
imshow(I2,map);
title('中值滤波（7x7）')

%% 高斯
[I,map]=imread('test2.tif');
figure(1);
subplot(2,2,1);
imshow(I,map);
title('原始图像');
k=1.5;
n=3;
Img = double(I); 
n1=floor((n+1)/2);
for i=1:n 
    for j=1:n 
      b(i,j) =exp(-((i-n1)^2+(j-n1)^2)/(4*k))/(4*pi*k); 
    end 
end 
Img1=conv2(Img,b,'same'); 
d=uint8(Img1);
subplot(2,2,2);
imshow(d,map);
title('高斯滤波（3x3）')
n=5;
n1=floor((n+1)/2);%计算图象中心 
for i=1:n 
    for j=1:n 
      b(i,j) =exp(-((i-n1)^2+(j-n1)^2)/(4*k))/(4*pi*k); 
    end 
end 
%生成高斯序列b。
Img1=conv2(Img,b,'same'); %用生成的高斯序列卷积运算，进行高斯滤波
d=uint8(Img1);
subplot(2,2,3);
imshow(d,map);
title('高斯滤波（5x5）')
n=7;
n1=floor((n+1)/2);%计算图象中心 
for i=1:n 
    for j=1:n 
      b(i,j) =exp(-((i-n1)^2+(j-n1)^2)/(4*k))/(4*pi*k); 
    end 
end 
%生成高斯序列b。
Img1=conv2(Img,b,'same'); %用生成的高斯序列卷积运算，进行高斯滤波
d=uint8(Img1);
subplot(2,2,4);
imshow(d,map);
title('高斯滤波（7x7）')


%%调用函数：
%% 中值
[I,map]=imread('test2.tif');
I1=medfilt2(I,[3 3]); 
figure(3);
imshow(I1,map);
title('中值滤波平滑后的test1.pgm(3x3)(调用medfilt2函数）');
%% 高斯
[I,map]=imread('test2.tif');
h=fspecial('gaussian',[3 3],1);%建立一个3*3模板的高斯滤波器
I1=imfilter(I,h,'conv');
figure;
imshow(I1,map);
title('高斯滤波平滑后的test1.pgm(3x3)(调用fspecial函数)');
