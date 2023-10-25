% Performing MUSIC algorithm with far-field pattern
function SMC(frequency,constant)

% Data Reading
load ../onlytum_1.mat onlytum1;
load ../homo_1.mat homo1;
load ../SimulationSetting.mat Setting;
load ../TestVectorData.mat Data;

% Fix the index as an integer
frequency_index=fix(1+(frequency-0.4)/0.01);

A=onlytum1(:,:,frequency_index);
B=homo1(:,:,frequency_index);
for j=1:size(A,2)
    A(j,j)=constant;
    B(j,j)=0;
end

clear onlytum1 homo1;

% Singular Value Decomposition
[U,~,V]=svd(A-B);

% Initialize searching area 
Y=zeros(size(Data.x_axis,2),size(Data.y_axis,2));

% number of nonzero singular values (setted)
count=1;

for j=1:size(Data.x_axis,2)
    for l=1:size(Data.y_axis,2)
        for s=1:count
            Y(l,j)=Y(l,j)+dot(reshape(Data.TestVector(j,l,:),[Setting.TotalNumber,1]),U(:,s))*dot(reshape(Data.TestVector(j,l,:),[Setting.TotalNumber,1]),conj(V(:,s)));
        end
    end
end

% Save plotdata
eval(['save ImagingData-' num2str(frequency) '-' num2str(constant) '.mat Y']);

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
set(gca,'TickLabelInterpreter','latex');
set(colorbar,'TickLabelInterpreter','latex');