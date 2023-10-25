th=(0:0.01:1)'*2*pi;
x_skin=0.01+0.05*cos(th);
y_skin=0.02+0.05*sin(th);

theta=linspace(-pi/2,-pi/2 +2*pi,17);
r_a=0.09;

figure('position',[300,300,370,300]);
hold on;
colormap('jet');
for s=1:size(theta,2)
    antenna_outside_x=r_a*cos(theta)+0.005*cos(th);
    antenna_outside_y=r_a*sin(theta)+0.005*sin(th);
    antenna_inside_x=r_a*cos(theta)+0.002*cos(th);
    antenna_inside_y=r_a*sin(theta)+0.002*sin(th);
    fill(antenna_outside_x,antenna_outside_y,'g','LineStyle','none');
    fill(antenna_inside_x,antenna_inside_y,'k','LineStyle','none');
end
fill(x_skin, y_skin,'c','LineStyle','none');
text(-0.043,-0.04,'$(\varepsilon_\star,\sigma_\star)=(15\varepsilon_0,0.5\mathrm{S/m})$','Interpreter','latex','fontsize',12);
box on;
colorbar;
xlabel('x-axis (m)');
ylabel('y-axis (m)');


% theta=linspace(-pi/2,-pi/2 +2*pi,17);
% r_a=0.09;
% 
% figure('position',[300,300,400,300]);
% %figure('position',[300,300,250,225]);
% axis square;
% plot(r_a*cos(theta),r_a*sin(theta),'o','markersize',12,'markerfacecolor','g','markeredgecolor','g');
% hold on
% plot(r_a*cos(theta),r_a*sin(theta),'o','markersize',4,'markerfacecolor','k','markeredgecolor','k');
% plot(0.01,0.02,'o','markersize',90,'markerfacecolor','c','markeredgecolor','c');
% %plot(0.01,0.02,'o','markersize',85,'markerfacecolor','c','markeredgecolor','c');
% %plot(0.01,0.03,'o','markersize',14,'markerfacecolor','r','markeredgecolor','r');
% shading flat;
% %grid on;
% %grid minor;
% box on;
% xlabel('x-axis (m)');
% ylabel('y-axis (m)');