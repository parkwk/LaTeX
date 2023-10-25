% Performing Direct Sampling Method
function DSM1(frequency,transmitting_antenna)

% Data Reading
load ../onlytum_1.mat onlytum1;
load ../homo_1.mat homo1;
eval(['load ../SimulationSetting' num2str(frequency*1000) ' Data']);

frequency_index=fix(1+(frequency-0.4)/0.01); % to fix the index as an integer
A=eval(['onlytum1(' num2str(transmitting_antenna) ',:,frequency_index)']);
B=eval(['homo1(' num2str(transmitting_antenna) ',:,frequency_index)']);

clear onlytum1 homo1 frequency_index;
A(1,transmitting_antenna)=0;
B(1,transmitting_antenna)=0;

% Initialize searching area 
Y=(0/0)*zeros(size(Data.x_axis,2),size(Data.y_axis,2));

% Axis limit
axis_limit=0.080;

for j=1:size(Data.x_axis,2)
    for l=1:size(Data.y_axis,2)
        search_point=[Data.x_axis(1,j) Data.y_axis(1,l)];
        if norm(search_point)<=axis_limit
            Y(l,j)=(A-B)*reshape(Data.TestVector(j,l,:),[1,Data.TotalNumber])';
        end
    end
end

% Boundary Drawing
th=0:0.01:2*pi;
c=axis_limit*cos(th);
d=axis_limit*sin(th);

eval(['save ImagingDataDSM1-' num2str(frequency) '-' num2str(transmitting_antenna) '.mat Y c d']);

load ../AntennaDrawing.mat;

% Plotting
figure('position',[300,300,370,300]);
contourf(Data.x_axis,Data.y_axis,abs(Y)/max(max(abs(Y))),'LineStyle','none');
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
fill(antenna_outside_x,antenna_outside_y,'g','LineStyle','none');
fill(antenna_outside_x(:,transmitting_antenna),antenna_outside_y(:,transmitting_antenna),'r','LineStyle','none');
fill(antenna_inside_x,antenna_inside_y,'k','LineStyle','none');