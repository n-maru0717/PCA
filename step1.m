clear all;
close all; % すべてのグローバル変数/ウィンドを消去

matX = load('sample2d.txt'); % sample2d.txt の読み込み
matXT = matX.';

xx=[min(matX(1,:)):.05:max(matX(1,:))];
[d,n]=size(matX); % matX の次元d とサンプル数n を取得

aveX1 = mean(matX(1,:));
aveX2 = mean(matX(2,:));

S = cov(matXT,1);
[V, LAMBDA] = eig(S);
LAMBDA_vector = max(LAMBDA);

[LAMBDA1,maxIndex] = max(LAMBDA_vector(:));

vector1 = V(:,maxIndex);
a = vector1(2,1)/vector1(1,1);
vector2 = V(:,1);
b = vector2(1,1)/vector2(2,1);
sum(vector1.*vector2)

figure(1),clf,hold on,plot(matX(1,:),matX(2,:),'bo');
figure(1),plot(aveX1,aveX2,'r*');
figure(1),plot(xx,a.*(xx-aveX1)+aveX2,'g-'); 
figure(1),plot(xx,b.*(xx-aveX1)+aveX2,'m-'); 

aveX1
aveX2
S
V
LAMBDA



grid minor on
axis square
