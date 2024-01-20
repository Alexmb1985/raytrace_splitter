function pos=next_impact(x,y,a_r,r_ext,r_int,cell,circ_1,m_circ_1,circ_2,m_circ_2,circ_3,m_circ_3,z,m_z)
pos(6)=0;
stop=0;
%%            
        % Incide sobre curva optimizada
            int_1=intersect(z,a_r,r_int,x,y);
            x_next(1)=int_1(1);
            y_next(1)=int_1(2);
            dist(1)=int_1(3); %3 es el liquido
            if x_next(1)==x
            m(1)=0;    
            else   
            m(1)=m_z(find(z(:,1)>x_next(1),1,'first')-1);
            end
        %cilindro ext arriba
            int_2=intersect(circ_1,a_r,r_ext,x,y); 
            x_next(2)=int_2(1);
            y_next(2)=int_2(2);
            dist(2)=int_2(3); %3 es el liquido
            if (x_next(2)==x) && (y_next(2)==y)
            m(2)=0;    
            else   
            m(2)=m_circ_1(find(circ_1(:,1)>x_next(2),1,'first')-1);
            end
            
            
        % Incide sobre el cilindro exteriorinf
            int_3=intersect(circ_2,a_r,r_ext,x,y);
            x_next(3)=int_3(1);
            y_next(3)=int_3(2);
            dist(3)=int_3(3); %3 es el liquido 
            if x_next(3)==x
            m(3)=0;    
            else   
            m(3)=m_circ_2(find(circ_2(:,1)>x_next(3),1,'first')-1);
            end
            
            
        % Incide sobre el cilindro interior
            int_4=intersect(circ_3,a_r,r_int,x,y);
            x_next(4)=int_4(1);
            y_next(4)=int_4(2);
            dist(4)=int_4(3); %3 es el liquido
            if x_next(4)==x
            m(4)=0;    
            else   
            m(4)=m_circ_3(find(circ_3(:,1)>x_next(4),1,'first')-1);
            end
            
            
        % Incide sobre la celula
            int_5=intersect(cell,a_r,r_int,x,y);
            x_next(5)=int_5(1);
            y_next(5)=int_5(2);
            dist(5)=int_5(3); %3 es el liquido 
            m(5)=0;
            
        %Escogemos el siguiente punto de corte del que tenga menos distancia
           [i,j]=find(dist==min(dist(dist>0.001)));
           
           if (min(dist(dist>0.001))>900) 
            stop=1;
            pos(1)=x;
            pos(2)=y;
            pos(3)=0;
            pos(5)=0;
            
            
            
           elseif (j==5)
            stop=1;
            pos(1)=x_next(j);
            pos(2)=y_next(j);
            pos(3)=dist(j);
            pos(5)=0;
            pos(6)=j;
               else 
            
            pos(1)=x_next(j);
            pos(2)=y_next(j);
            pos(3)=dist(j);
            pos(5)=m(j);
            pos(6)=j;
           end

            pos(4)=stop;

        



end