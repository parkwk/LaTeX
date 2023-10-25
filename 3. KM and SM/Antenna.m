load homo_1.mat;
for j=1:271
A(1,j)=homo1(1,1,j);
C(1,j)=-10;
end
B=mag2db(abs(A));
x=0.4:0.01:3.1;

figure('position',[300,300,800,300]);
plot(x,B);
hold on
plot(x,C);
box on;
xlabel('Frequency / GHz');
ylabel('Magnitude');
title('S-parameters (magnitudes in dB)');
xlim([0.4,3.1]);