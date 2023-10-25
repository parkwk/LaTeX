% Performing MUSIC algorithm via S-parameters
function MUSIC2(frequency)

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
% Singular Value Decomposition
[U,~,~]=svd(A-B);

% Initialize searching area 
Y=zeros(size(Data.x_axis,2),size(Data.y_axis,2));

% number of nonzero singular values (setted)
count=2;
    
% Generating projection operator
U1=zeros(Data.TotalNumber,count);
for j=1:count
    U1(:,j)=U(:,j);
end
Projection_operator=eye(Data.TotalNumber,Data.TotalNumber)-U1*U1';

for j=1:size(Data.x_axis,2)
    for l=1:size(Data.y_axis,2)
        Y(l,j)=1/norm(Projection_operator*reshape(Data.TestVector(j,l,:),[Data.TotalNumber,1]));
    end
end

% Save plotdata
eval(['save MUSICImaging2-' num2str(frequency*1000) '.mat Y']);

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