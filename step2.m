clear all;
close all; % すべてのグローバル変数/ウィンドを消去

matX = load('iris4d.txt'); % sample2d.txt の読み込み
matXT = matX.';

xx=[min(matX(1,:)):.05:max(matX(1,:))];
[d,n]=size(matX); % matX の次元d とサンプル数n を取得

aveX1 = mean(matX(1,:));
aveX2 = mean(matX(2,:));
aveX3 = mean(matX(3,:));
aveX4 = mean(matX(4,:));

S = cov(matXT,1);
[V, LAMBDA] = eig(S);
 
LAMBDA_vector = max(LAMBDA);
LAMBDA_vector

[sorted,Index] = sort(LAMBDA_vector,'descend');
vector1 = V(:,Index(1,1));
a = vector1(2,1)/vector1(1,1);
x1 = vector1.'*matX;
vector2 = V(:,Index(1,2));
b = vector2(1,1)/vector2(2,1);
x2 = vector2.'*matX;

figure(1),plot(x1(1:50),x2(1:50),'ro',x1(51:100),x2(51:100),'go',x1(101:150),x2(101:150),'bo');

sumLAMBDA = sum(sorted);
Acc1 = sum(sorted(1,1))/sumLAMBDA;
Acc2 = sum(sorted(1,1:2))/sumLAMBDA;
Acc3 = sum(sorted(1,1:3))/sumLAMBDA;
Acc = [Acc1,Acc2,Acc3,1];

figure(2),plot(Acc);

grid minor on
axis square

