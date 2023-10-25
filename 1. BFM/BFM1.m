% Performing BiFocusing Method
function BFM1(frequency)

load ../onlytum_1.mat onlytum1;
load ../homo_1.mat homo1;
eval(['load ../SimulationSetting' num2str(frequency*1000) ' Data']);

% Fix the index as an integer
frequency_index=fix(1+(frequency-0.4)/0.01);

A=onlytum1(:,:,frequency_index);
B=homo1(:,:,frequency_index);
for j=1:size(A,2)
    A(j,j)=0;
    B(j,j)=0;
end

clear onlytum1 homo1;

% Parameter initialize
Y=zeros(size(Data.x_axis,2),size(Data.y_axis,2));

% Axis limit
axis_limit=0.080;

for j=1:size(Data.x_axis,2)
    for l=1:size(Data.y_axis,2)
        search_point=[Data.x_axis(1,j) Data.y_axis(1,l)];
        if norm(search_point)<=axis_limit
            Y(l,j)=transpose(1./reshape(Data.TestVector(j,l,:),[Data.TotalNumber,1]))*(A-B)*(1./reshape(Data.TestVector(j,l,:),[Data.TotalNumber,1]));
        end
    end
end

% Save plotdata
eval(['save BFImaging1-' num2str(frequency*1000) '.mat Y']);

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
xlim(axis_limit*[-1 1]);
ylim(axis_limit*[-1 1]);
set(gca,'TickLabelInterpreter','latex');
set(colorbar,'TickLabelInterpreter','latex');