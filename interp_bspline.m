function sol=interp_bspline(z)



%% b-splines
n=length(z(:,1));
% order=3;
order=6;

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

aux=interp1(p_spl(:,1),p_spl(:,2),-30:0.125:30);
sol(:,1)=-30:0.125:30';
sol(:,2)=aux';

end
