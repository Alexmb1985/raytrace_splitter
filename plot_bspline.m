function y=plot_bspline(z)
% n_punto=6;
% z=zeros(n_punto,2);%coordenadas x e y de cada punto de la curva concentradora, en principio consideramos 31 puntos
% 
% z(:,1)=0:1:5; %x
% z(:,2)=[0 1 3 -3 0 0.5]';
% xx=0:0.25:5;


xx=-30:0.5:0;

m_z=diff(z(:,2))./diff(z(:,1)); %vector de pendientes de la curva



% figure; 
hold all;

%% b-splines
n=length(z(:,1));
order=5;

nplot = 100;

if (n < order)
	display([' !!! Error: Choose n >= order=',num2str(order),' !!!']);
	return;
end

% figure(1);
% hold on; box on;
% set(gca,'Fontsize',16);

t = linspace(0,1,nplot);

for i = 1:n	
	p(i,:) = z(i,:);
 	hold off;
% 	plot(p(:,1),p(:,2),'k-');
%  	axis([0 1 0 1]);
	hold on; box on;
	if (i  >= order) 
		T = linspace(0,1,i-order+2);
		y = linspace(0,1,1000);
		p_spl = DEBOOR(T,p,y,order);
		
	end
% 	plot(p(:,1),p(:,2),'ro','MarkerSize',6,'MarkerFaceColor','r');
end
% title(['B-Spline-curve with ',num2str(n),' control points of order ',num2str(order)]);
%% plotiing
% x0Max=-30;
% Radius=30;
% NMirror = 100;
% NMirror2 = 200;
% xMirror=zeros(NMirror);
% yMirror=zeros(NMirror);
xlim([0 30])
% for i=1:NMirror
%     xMirror(i) = -x0Max + (i-1)/(NMirror-1)*(2*x0Max);
%     yMirror(i) = sqrt(Radius^2 - xMirror(i)^2);
% end
% for l=NMirror+1:NMirror2
%     yMirror(l) = -yMirror(l-100);
%     xMirror(l) = -xMirror(l-100);
% end
% plot(xMirror,yMirror,'k-');
plot(p_spl(:,1),p_spl(:,2),'-','LineWidth',1.1);
ylabel('y (millimeters)')
xlabel('x (millimeters)')
y=p_spl
end
