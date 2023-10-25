th=(0:0.01:1)'*2*pi;
x1=0.01+0.01*cos(th);
y1=0.03+0.01*sin(th);

x2=-0.04+0.01*cos(th);
y2=-0.02+0.01*sin(th);

theta=linspace(-pi/2,-pi/2 +2*pi,17);
r_a=0.09;

antenna_outside_x=r_a*cos(theta)+0.005*cos(th);
antenna_outside_y=r_a*sin(theta)+0.005*sin(th);
antenna_inside_x=r_a*cos(theta)+0.002*cos(th);
antenna_inside_y=r_a*sin(theta)+0.002*sin(th);

save Configuration_multitum antenna_inside_x antenna_inside_y antenna_outside_x antenna_outside_y r_a th theta x1 x2 y1 y2;

figure('position',[300,300,370,300]);
hold on;
colormap('jet');
fill(antenna_outside_x,antenna_outside_y,'g','LineStyle','none');
fill(antenna_inside_x,antenna_inside_y,'k','LineStyle','none');
fill(x1, y1,'r','LineStyle','none');
fill(x2, y2,'r','LineStyle','none');
box on;
colorbar;
xlabel('x-axis (m)');
ylabel('y-axis (m)');
text(-0.04,0.01,'$(\varepsilon_1,\sigma_1)=(55\varepsilon_0,1.2\mathrm{S/m})$','Interpreter','latex','fontsize',12);
text(-0.07,-0.04,'$(\varepsilon_2,\sigma_2)=(45\varepsilon_0,1.0\mathrm{S/m})$','Interpreter','latex','fontsize',12);
%$(\varepsilon_{\mathrm{r}1},\sigma_\star)=(55,1.2\mathrm{S/m})$
%$(\varepsilon_{\mathrm{r}2},\sigma_\star)=(55,1.2\mathrm{S/m})$

figure('position',[300,300,370,300]);
hold on;
colormap('jet');
fill(antenna_outside_x,antenna_outside_y,'g','LineStyle','none');
fill(antenna_inside_x,antenna_inside_y,'k','LineStyle','none');
fill(x1, y1,'r','LineStyle','none');
fill(x2, y2,[0.66,0.25,1.0],'LineStyle','none');
text(-0.04,0.01,'$(\varepsilon_1,\sigma_1)=(55\varepsilon_0,1.2\mathrm{S/m})$','Interpreter','latex','fontsize',12);
text(-0.07,-0.04,'$(\varepsilon_2,\sigma_2)=(45\varepsilon_0,1.0\mathrm{S/m})$','Interpreter','latex','fontsize',12);
box on;
colorbar;
xlabel('$x-\mathrm{axis~(m)}$','Interpreter','Latex');
ylabel('$y-\mathrm{axis~(m)}$','Interpreter','Latex');
set(gca,'TickLabelInterpreter','latex');
set(colorbar,'TickLabelInterpreter','latex');
%colormap('jet');

%figure('position',[300,300,250,225]);
%axis square;
%plot(r_a*cos(theta),r_a*sin(theta),'o','markersize',12,'markerfacecolor','g','markeredgecolor','g');
%hold on
%plot(r_a*cos(-pi/2),r_a*sin(-pi/2),'o','markersize',12,'markerfacecolor','r','markeredgecolor','r');
%plot(r_a*cos(theta),r_a*sin(theta),'o','markersize',4,'markerfacecolor','k','markeredgecolor','k');
%plot(0.01,0.02,'o','markersize',93,'markerfacecolor','b','markeredgecolor','b');
%plot(0.01,0.02,'o','markersize',88,'markerfacecolor','c','markeredgecolor','c');
%plot(0.01,0.03,'o','markersize',14,'markerfacecolor','r','markeredgecolor','r');
%plot(-0.04,-0.02,'o','markersize',14,'markerfacecolor','r','markeredgecolor','r');
%shading flat;
%grid on;
%grid minor;