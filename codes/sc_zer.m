%% read dataset
load mfeat-zer

%% set up sample data -- for 2 clusters test
%taking the first 50 patters of 0 
%and the first 50 patterns of 1
testpts=[mfeat_zer(1:50,:);mfeat_zer(201:250,:)];
goto=size(testpts,1);

%randomly permute the data
%testpts=testpts(randperm(100),:);


%% compute the similarity matrix W
%sigsq open to modify
sigsq=55000;

W=zeros(goto);
for i=1:goto
    for j=1:goto
        W(i,j)=exp(-(norm(testpts(i,:)-testpts(j,:)))^2/sigsq);
    end
end
for i=1:goto
    W(i,i)=0;
end

%plot the similarity martrix
subplot(2,5,1)
imagesc(W); colorbar;

%% compute the Laplacian
D=diag(sum(W'));
L=D^(-.5)*W*D^(-.5);

%plot the Laplacian
subplot(2,5,2)
imagesc(L); colorbar;

%% compute top k eigenvectors of L as X 
[X,V]=eig(L);
[Xsort,Vsort]=eigsort(X,V);
Xuse=Xsort(:,1:2);

%plot X
subplot(2,5,3);
imagesc(Xuse); colorbar;


%% normalize X to get Y
Xsq=Xuse.*Xuse;
divmat=repmat(sqrt(sum(Xsq')'),1,2);
Y=Xuse./divmat;

%plot Y
subplot(2,5,4);
imagesc(Y); colorbar;

%% perform kmeans on Y and plot
ind=kmeans(Y,2);
subplot(2,5,5)
plot(ind);

%% redo test on all 10 numbers with 50 patterns each
testpts=[mfeat_zer(1:50,:);mfeat_zer(201:250,:);
         mfeat_zer(401:450,:);mfeat_zer(601:650,:)
         mfeat_zer(801:850,:);mfeat_zer(1001:1050,:)
         mfeat_zer(1201:1250,:);mfeat_zer(1401:1450,:)
         mfeat_zer(1601:1650,:);mfeat_zer(1801:1850,:)];
goto=size(testpts,1);

W=zeros(goto);
for i=1:goto
    for j=1:goto
        W(i,j)=exp(-(norm(testpts(i,:)-testpts(j,:)))^2/sigsq);
    end
end
for i=1:goto
    W(i,i)=0;
end
subplot(2,5,6)
imagesc(W); colorbar;
D=diag(sum(W'));
L=D^(-.5)*W*D^(-.5);
subplot(2,5,7)
imagesc(L); colorbar;
[X,V]=eig(L);
[Xsort,Vsort]=eigsort(X,V);
Xuse=Xsort(:,1:10);
subplot(2,5,8);
imagesc(Xuse); colorbar;
Xsq=Xuse.*Xuse;
divmat=repmat(sqrt(sum(Xsq')'),1,10);
Y=Xuse./divmat;
subplot(2,5,9);
imagesc(Y); colorbar;
ind=kmeans(Y,10);
subplot(2,5,10)
plot(ind);