% Performing MUSIC algorithm with far-field pattern
function KirM4(antenna,frequency1,frequency2)

% Data Reading
eval(['load wtum_' num2str(antenna) '.mat']);
eval(['load homo_' num2str(antenna) '.mat']);
frequency=frequency1:0.01:frequency2;
frequency_index=fix(1+(frequency1-0.4)/0.01)-1:1:fix(1+(frequency2-0.4)/0.01); % to fix the index as an integer
%A=eval(['wotum' num2str(antenna) '(:,:,frequency_index)']);
%B=eval(['homo' num2str(antenna) '(:,:,frequency_index)']);

% Parameter initialize
N=16;                           % total number of antennas
sigma_back=0.2;                 % initial conductivity
epsilon_0=8.854187818e-12;      % initial permittivity
mu_0=4*pi*1e-7;                 % initial permeability
G=1e9;                          % Giga Hertz
epsilon_back=epsilon_0*20;      % background permittivity

% Initialize searching area 
a=-0.1:0.002:0.1; % x-axis
b=-0.1:0.002:0.1; % y-axis
Y=zeros(size(a,2),size(b,2));

Wbar=waitbar(0,'Kirchhoff migration');
for s=1:size(frequency,2)
    A=eval(['wtum' num2str(antenna) '(:,:,frequency_index(1,s))']);
    B=eval(['homo' num2str(antenna) '(:,:,frequency_index(1,s))']);
    omega=2*pi*frequency(1,s)*G;         % Angular frequency
    k_back=omega*sqrt(mu_0*epsilon_back); % background wavenumber
    k=k_back*sqrt(1+1i*sigma_back/(epsilon_back*omega)); % wavenumber
    for j=1:size(a,2)
        for l=1:size(b,2)
            search_point=[a(1,j) b(1,l)];
            TestVector_temp=zeros(N,1);
            for m=1:N
                antenna_number=-pi/2 -(2*pi*(m-1))/N;
                antenna_location=0.09*[cos(antenna_number) sin(antenna_number)];
                TestVector_temp(m,1)=1i*(besselh(0,2,k*norm(search_point-antenna_location)))/4;
            end
            TestVector=TestVector_temp/norm(TestVector_temp);
            Y(l,j)=Y(l,j)+TestVector'*(A-B)*conj(TestVector);
        end
    end
    waitbar(s/size(frequency,2));
end
close(Wbar);
% Boundary drawing
%th=0:0.01:2*pi;
%c=0.085*cos(th);
%d=0.085*sin(th);

% Save plotdata
eval(['save plotdataKirM4-' num2str(antenna) '.mat a b Y']);

% Plotting
figure('position',[300,300,400,300]);
contourf(a,b,abs(Y));
hold on;
shading flat;
colorbar;
box on;
%plot(c,d,'k','LineWidth',2);
xlabel('x-axis (m)');
ylabel('y-axis (m)');