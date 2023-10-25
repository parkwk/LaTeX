th=(0:0.01:1)'*2*pi;
x=0.01+0.01*cos(th);
y=0.03+0.01*sin(th);

theta=linspace(-pi/2,-pi/2 +2*pi,17);
r_a=0.09;

antenna_outside_x=r_a*cos(theta)+0.005*cos(th);
antenna_outside_y=r_a*sin(theta)+0.005*sin(th);
antenna_inside_x=r_a*cos(theta)+0.002*cos(th);
antenna_inside_y=r_a*sin(theta)+0.002*sin(th);

save Configuration_onlytum antenna_inside_x antenna_inside_y antenna_outside_x antenna_outside_y r_a th theta x y;

figure('position',[300,300,370,300]);
hold on;
colormap('jet');
colorbar;
fill(antenna_outside_x,antenna_outside_y,'g','LineStyle','none');
fill(antenna_inside_x,antenna_inside_y,'k','LineStyle','none');
fill(x, y,'r','LineStyle','none');
box on;
xlabel('$x-\mathrm{axis~(m)}$','Interpreter','Latex');
ylabel('$y-\mathrm{axis~(m)}$','Interpreter','Latex');
set(gca,'TickLabelInterpreter','latex');
set(colorbar,'TickLabelInterpreter','latex');
text(-0.04,0.01,'$(\varepsilon,\sigma)=(55\varepsilon_0,1.2\mathrm{S/m})$','Interpreter','latex','fontsize',12);



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