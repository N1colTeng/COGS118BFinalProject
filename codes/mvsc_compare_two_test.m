disp("compare which two views?");
view1=input("first view:",'s');
view2=input("second view:",'s');

dset1=load("mfeat-"+view1);
dset2=load("mfeat-"+view2);

disp("compare which two numbers?");
num1=input("first number:");
num2=input("second number:");

numCmp=input("compare how many patterns each (max 200)?");


testpts1=[dset1(200*num1+1:200*num1+numCmp,:);
          dset1(200*num2+1:200*num2+numCmp,:)];
testpts2=[dset2(200*num1+1:200*num1+numCmp,:);
          dset2(200*num2+1:200*num2+numCmp,:)];
goto=size(testpts1,1);

Av1=zeros(goto);
Av2=zeros(goto);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%set sigsq1&2 according to the views
sigsq1=750;
sigsq2=240;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

for i=1:goto
    for j=1:goto
        Av1(i,j)=exp(-(norm(testpts1(i,:)-testpts1(j,:)))^2/sigsq1);
    end
end
for i=1:goto
    for j=1:goto
        Av2(i,j)=exp(-(norm(testpts2(i,:)-testpts2(j,:)))^2/sigsq2);
    end
end
for i=1:goto
    Av1(i,i)=0;
    Av2(i,i)=0;
end
W=Av1*Av2;
Asmd=[zeros(goto),W;W',zeros(goto)];
subplot(1,5,1)
imagesc(Asmd); colorbar;
D=diag(sum(Asmd'));
L=D^(-.5)*Asmd*D^(-.5);
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