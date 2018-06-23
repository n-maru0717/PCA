clear all;
close all; % すべてのグローバル変数/ウィンドを消去

matX = imread('1.ppm');
gray_mapX = rgb2gray(matX);
stX = reshape(gray_mapX,[],1);
[n1,d1] = size(stX);

for i = 2:25
  filename = strcat(num2str(i),'.ppm');
  matImg = imread(filename);
  gray_mapX = rgb2gray(matImg);
  vecX1 = reshape(gray_mapX,[],1);
  stX = [stX,vecX1];
endfor

%matXT = matX.';
stXT = stX.';

xx=[min(stX(1,:)):.05:max(stX(1,:))];
[d,n]=size(stX); % matX の次元d とサンプル数n を取得

d
n

S = cov(stXT,1);
[V, LAMBDA] = eig(S);
size(S)
size(V)
size(LAMBDA)
LAMBDA_vector = max(LAMBDA);

[sorted,Index] = sort(LAMBDA_vector,'descend');
size(sorted)

vector1 = V(:,Index(1,1));
vector = vector1;

for i = 2:16
  vector1 = V(:,Index(1,i));
  vector = [vector,vector1];
endfor  
size(vector)

for i = 1:16
  filename = strcat('img',num2str(i),'.jpg');
  fix_img = reshape(vector(:,i),[],86);
  fix_img = fix_img.*64;
  imwrite(fix_img,filename);
endfor
