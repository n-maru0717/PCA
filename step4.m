clear all;
close all; % すべてのグローバル変数/ウィンドを消去

matXT = csvread('prefpop3age.csv');
matX = matXT.';

xx=[min(matX(1,:)):.05:max(matX(1,:))];
[d,n]=size(matX); % matX の次元d とサンプル数n を取得

aveX1 = mean(matX(1,:));
aveX2 = mean(matX(2,:));
aveX3 = mean(matX(3,:));
aveX4 = mean(matX(4,:));

m = sum(matX,2)./n;
m

S = cov(matXT,1);
[V, LAMBDA] = eig(S);
 
LAMBDA_vector = max(LAMBDA);
LAMBDA_vector

[sorted,Index] = sort(LAMBDA_vector,'descend');
vector1 = V(:,Index(1,1));
x1 = vector1.'*matX;
vector2 = V(:,Index(1,2));
x2 = vector2.'*matX;
vector3 = V(:,Index(1,3));
x3 = vector3.'*matX;
vector4 = V(:,Index(1,4));
x4 = vector4.'*matX;

Ur1 = [vector1];
Ur2 = [vector1,vector2];
Ur3 = [vector1,vector2,vector3];
Ur4 = [vector1,vector2,vector3,vector4];

x_r1 = m + Ur1*Ur1.'*(matX - m);
x_r2 = m + Ur2*Ur2.'*(matX - m);
x_r3 = m + Ur3*Ur3.'*(matX - m);
x_r4 = m + Ur4*Ur4.'*(matX - m);

error_r1 = sum(sum((matX - x_r1)*(matX - x_r1).'))./n;
error_r2 = sum(sum((matX - x_r2)*(matX - x_r2).'))./n;
error_r3 = sum(sum((matX - x_r3)*(matX - x_r3).'))./n;
error_r4 = sum(sum((matX - x_r4)*(matX - x_r4).'))./n;

sumLAMBDA = sum(sorted);
Acc1 = sum(sorted(1,1))/sumLAMBDA;
Acc2 = sum(sorted(1,1:2))/sumLAMBDA;
Acc3 = sum(sorted(1,1:3))/sumLAMBDA;
Acc = [Acc1,Acc2,Acc3,1];

figure(1),plot(x1(1:7),x2(1:7),'bo',x1(7:14),x2(7:14),'co',x1(14:24),x2(14:24),'go',x1(24:30),x2(24:30),'yo',x1(31:40),x2(31:40),'mo',x1(41:47),x2(41:47),'ro');

error_r = [error_r1,error_r2, error_r3, error_r4];
figure(2),plot(error_r,'r-');

figure(3),plot(Acc);
grid minor on
axis square

