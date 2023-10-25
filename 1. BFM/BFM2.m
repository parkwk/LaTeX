% Performing BiFocusing Method
function BFM2(frequency)

load ../Smallcase2_S.mat Smallcase21;
load ../homo_1.mat homo1;
eval(['load ../SimulationSetting2-' num2str(frequency*1000) ' Data']);

% Fix the index as an integer
frequency_index=fix(1+(frequency-0.4)/0.01);

A=Smallcase21(:,:,frequency_index);
B=homo1(:,:,frequency_index);
for j=1:size(A,2)
    A(j,j)=0;
    B(j,j)=0;
end

clear Smallcase21 homo1;

% Parameter initialize
Y=zeros(size(Data.x_axis,2),size(Data.y_axis,2));

for j=1:size(Data.x_axis,2)
    for l=1:size(Data.y_axis,2)
            Y(l,j)=transpose(1./reshape(Data.TestVector(j,l,:),[Data.TotalNumber,1]))*(A-B)*(1./reshape(Data.TestVector(j,l,:),[Data.TotalNumber,1]));
    end
end

% Save plotdata
eval(['save BFImaging2-' num2str(frequency*1000) '.mat Y']);

% Plotting
figure('position',[300,300,370,300]);
contourf(Data.x_axis,Data.y_axis,abs(Y),'LineStyle','none');
colormap('jet');
hold on;
shading flat;
colorbar;
box on;
xlabel('$x-\mathrm{axis~(m)}$','Interpreter','Latex');
ylabel('$y-\mathrm{axis~(m)}$','Interpreter','Latex');
xlim(Data.axis_limit*[-1 1]);
ylim(Data.axis_limit*[-1 1]);
set(gca,'TickLabelInterpreter','latex');
set(colorbar,'TickLabelInterpreter','latex');