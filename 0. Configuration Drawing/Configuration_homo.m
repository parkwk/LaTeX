theta=linspace(-pi/2,-pi/2 +2*pi,17);
th=(0:0.01:1)'*2*pi;
r_a=0.09;

antenna_outside_x=r_a*cos(theta)+0.005*cos(th);
antenna_outside_y=r_a*sin(theta)+0.005*sin(th);
antenna_inside_x=r_a*cos(theta)+0.002*cos(th);
antenna_inside_y=r_a*sin(theta)+0.002*sin(th);

save Configuration_homo antenna_inside_x antenna_inside_y antenna_outside_x antenna_outside_y r_a th theta;

figure('position',[300,300,370,300]);
hold on;
colormap('jet');
colorbar;
fill(antenna_outside_x,antenna_outside_y,'g','LineStyle','none');
fill(antenna_inside_x,antenna_inside_y,'k','LineStyle','none');
box on;
xlabel('x axis (m)');
ylabel('y axis (m)');
text(-0.05,0,'$(\varepsilon_{\mathrm{b}},\sigma_{\mathrm{b}})=(20\varepsilon_0,0.2\mathrm{S/m})$','Interpreter','latex','fontsize',12);