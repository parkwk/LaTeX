% Performing MUSIC algorithm via S-parameters
function KIR2(frequency)

% Data Reading
load ../Smallcase2_S.mat Smallcase21;
load ../homo_1.mat homo1;
eval(['load ../SimulationSetting' num2str(frequency*1000) ' Data']);

% Fix the index as an integer
frequency_index=fix(1+(frequency-0.4)/0.01);

A=Smallcase21(:,:,frequency_index);
B=homo1(:,:,frequency_index);
for j=1:size(A,2)
    A(j,j)=0;
    B(j,j)=0;
end

clear onlytum1 homo1;

% Parameter initialize
Y=zeros(size(Data.x_axis,2),size(Data.y_axis,2));

for j=1:size(Data.x_axis,2)
    for l=1:size(Data.y_axis,2)
        Y(l,j)=reshape(Data.TestVector(j,l,:),[Data.TotalNumber,1])'*(A-B)*conj(reshape(Data.TestVector(j,l,:),[Data.TotalNumber,1]));
    end
end

% Save plotdata
eval(['save KMImaging2-' num2str(frequency*1000) '.mat Y']);

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