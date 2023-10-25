% Performing Kirchhoff migration
function KMC(frequency,constant)

% Data Reading
load ../onlytum_1.mat onlytum1;
load ../homo_1.mat homo1;
%load ../SimulationSetting.mat Setting;
eval(['load ../SimulationSetting' num2str(frequency*1000) '.mat']);
%load ../TestVectorData.mat Data;

% Fix the index as an integer
frequency_index=fix(1+(frequency-0.4)/0.01);

A=onlytum1(:,:,frequency_index);
B=homo1(:,:,frequency_index);
for j=1:size(A,2)
    A(j,j)=constant;
    B(j,j)=0;
end

clear onlytum1 homo1;

axis_limit=0.085;

% Parameter initialize
Y=zeros(size(Data.x_axis,2),size(Data.y_axis,2));

for j=1:size(Data.x_axis,2)
    for l=1:size(Data.y_axis,2)
        if sqrt(Data.x_axis(1,j)^2+Data.y_axis(1,l)^2)<=axis_limit
            Y(l,j)=abs(reshape(Data.TestVector(j,l,:),[Data.TotalNumber,1])'*(A-B)*conj(reshape(Data.TestVector(j,l,:),[Data.TotalNumber,1])));
        else
            Y(l,j)=NaN;
        end
    end
end

% Save plotdata
eval(['save KMCImaging1-' num2str(frequency) '-' num2str(constant) '.mat Y']);


% Boundary Drawing
th=0:0.01:2*pi;
c=axis_limit*cos(th);
d=axis_limit*sin(th);

% Plotting
figure('position',[300,300,370,300]);
contourf(Data.x_axis,Data.y_axis,abs(Y),'LineStyle','none');
colormap('jet');
hold on;
plot(c,d,'k','LineWidth',2);
shading flat;
colorbar;
box on;
xlabel('$x-\mathrm{axis~(m)}$','Interpreter','Latex');
ylabel('$y-\mathrm{axis~(m)}$','Interpreter','Latex');
set(gca,'TickLabelInterpreter','latex');
set(colorbar,'TickLabelInterpreter','latex');