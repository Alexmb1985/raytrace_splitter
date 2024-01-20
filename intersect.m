function pos=intersect(z,a_r,r,x,y)
            
            if abs(tand(a_r))~=inf
                m=tand(a_r);
                n=y-(x*tand(a_r));
            else
                m=0;
                n=0;
            end;    
           
            opt_1=InterX([z(:,1)';z(:,2)'],[x (r*(-1)^(cosd(a_r)<0))*(abs(tand(a_r))~=inf)+x*(abs(tand(a_r))==inf);y (m*r*(-1)^(cosd(a_r)<0)+n)*(abs(tand(a_r))~=inf)+(y+60*sign(sind(a_r)))*(abs(tand(a_r))==inf)]);
            if isempty(opt_1)
            pos(1)=x;
            pos(2)=y;
            pos(3)=1000;                
            else
            distancias_1=pdist([x,y;opt_1(1,:)',opt_1(2,:)'],'euclidean');
            %cogemos solo las distancias hastra la curva que nos interesa,
            %no las otras combinaciones
            distancias_obj=distancias_1(1:length(opt_1(1,:)));
            distancia_1=min(distancias_obj(distancias_obj>0.001));
%             [i,j]=find(distancias_1==min(distancias_1(1:length(opt_1(1,:)))));
            if isempty(distancia_1)
                j=[];
            else    
            [i,j]=find(distancias_obj== distancia_1);
            end;
            
            if isempty(j)
            pos(1)=x;
            pos(2)=y;
            pos(3)=1000;  
            else
            pos(1)=opt_1(1,min(j));
            pos(2)=opt_1(2,min(j));
            pos(3)=distancia_1;
            end;
end