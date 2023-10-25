% Performing MUSIC algorithm with far-field pattern
function KirFarMulti3(antenna,frequencylow,frequencyhigh)

% Data Reading
eval(['load wotum_' num2str(antenna) '.mat']);
eval(['load homo_' num2str(antenna) '.mat']);

% Initialize searching area 
a=-0.1:0.0025:0.1; % x-axis
b=-0.1:0.0025:0.1; % y-axis
Y=zeros(size(a,2),size(b,2));

count=0;    
for frequency=frequencylow:0.01:frequencyhigh
    count=count+1;
    frequency_index=fix(1+(frequency-0.4)/0.01); % to fix the index as an integer
    A=eval(['wotum' num2str(antenna) '(:,:,frequency_index)']);
    B=eval(['homo' num2str(antenna) '(:,:,frequency_index)']);
    
    % Parameter initialize
    N=16;                           % total number of antennas
    sigma_back=0.2;                 % initial conductivity
    epsilon_0=8.854187818e-12;      % initial permittivity
    mu_0=4*pi*1e-7;                 % initial permeability
    G=1e9;                          % Giga Hertz
    omega=2*pi*frequency*G;         % Angular frequency
    epsilon_back=epsilon_0*20;      % background permittivity
    k_back=omega*sqrt(mu_0*epsilon_back); % background wavenumber
    k=k_back*sqrt(1-1i*sigma_back/(epsilon_back*omega)); % wavenumber
    
    % Initialize test vector
    for j=1:size(a,2)
        for l=1:size(b,2)
            search_point=[a(1,j) b(1,l)];
            TestVector_temp=zeros(N,1);
            for m=1:N
                antenna_number=-pi/2 -(2*pi*(m-1))/N;
                antenna_location=0.09*[cos(antenna_number) sin(antenna_number)];
                TestVector_temp(m,1)=exp(-1i*k*norm(search_point-antenna_location));
            end
            TestVector=TestVector_temp/norm(TestVector_temp);
            Y(l,j,count)=TestVector'*(A-B)*conj(TestVector);
        end
    end
end

Z=zeros(size(Y,1),size(Y,2));
for s=1:size(Y,3)
    Z(:,:)=Z(:,:)+Y(:,:,s);
end

% Save plotdata
eval(['save plotdataKirFarMulti3-' num2str(antenna) '.mat a b Y Z']);

% Plotting
figure('position',[300,300,400,300]);
contourf(a,b,abs(Z)/max(max(abs(Z))));
hold on;
shading flat;
colorbar;
box on;
xlabel('x-axis (m)');
ylabel('y-axis (m)');