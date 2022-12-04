load mfeat-pix

disp("compare which two numbers?");
num1=input("first number:");
num2=input("second number:");

numCmp=input("compare how many patterns each (max 200)?");


testpts=[mfeat_pix(200*num1+1:200*num1+numCmp,:);
         mfeat_pix(200*num2+1:200*num2+numCmp,:)];
goto=size(testpts,1);
W=zeros(goto);

%set sigsq
sigsq=750;

for i=1:goto
    for j=1:goto
        W(i,j)=exp(-(norm(testpts(i,:)-testpts(j,:)))^2/sigsq);
    end
end
for i=1:goto
    W(i,i)=0;
end
subplot(1,5,1)
imagesc(W); colorbar;
D=diag(sum(W'));
L=D^(-.5)*W*D^(-.5);
subplot(1,5,2)
imagesc(L); colorbar;
[X,V]=eig(L);
[Xsort,Vsort]=eigsort(X,V);
Xuse=Xsort(:,1:2);
subplot(1,5,3);
imagesc(Xuse); colorbar;
Xsq=Xuse.*Xuse;
divmat=repmat(sqrt(sum(Xsq')'),1,2);
Y=Xuse./divmat;
subplot(1,5,4);
imagesc(Y); colorbar;
ind=kmeans(Y,2);
subplot(1,5,5)
plot(ind);