function recorte_curva(z)
%% DEFINICIÓN POLINOMIO
t_cell=6;
r_cell=-27.839;

Radius=30;%Radio del cilindro exterior mm
r_ext=30;
r_int=28;

cell=[-t_cell/2, r_cell; t_cell/2, r_cell];

res=0.001;

circ_1=zeros(length(-r_ext:res:r_ext),2);
circ_1(:,1)=-r_ext:res:r_ext;
circ_1(:,2)=sqrt(r_ext^2-(-r_ext:res:r_ext).^2);
m_circ_1=diff(circ_1(:,2))./diff(circ_1(:,1));

circ_2=zeros(length(-r_ext:res:r_ext),2);
circ_2(:,1)=-r_ext:res:r_ext;
circ_2(:,2)=-sqrt(r_ext^2-(-r_ext:res:r_ext).^2);
m_circ_2=diff(circ_2(:,2))./diff(circ_2(:,1));

circ_3=zeros(length(-r_int:res:r_int),2);
circ_3(:,1)=-r_int:res:r_int;
circ_3(:,2)=-sqrt(r_int^2-(-r_int:res:r_int).^2);
m_circ_3=diff(circ_3(:,2))./diff(circ_3(:,1));

hold all;



%% Curva concentradora
z1(:,1)=[z(:,1);flipud(-z(1:20,1))];
z1(:,2)=[z(:,2);flipud(z(1:20,2))];

z_prev=z1;

joint=InterX([z_prev(:,1)';z_prev(:,2)'],[circ_3(:,1)';-circ_3(:,2)']);

if isempty(joint)
    joint=InterX([z_prev(:,1)';z_prev(:,2)'],[circ_3(:,1)';circ_3(:,2)']);   

    aux_1=[(z_prev(:,1)>joint(1,1)).*(z_prev(:,1)<joint(1,2)).*z_prev(:,1)]';
    aux_2=[(z_prev(:,1)>joint(1,1)).*(z_prev(:,1)<joint(1,2)).*z_prev(:,2)]';

    middle=aux_1(find(aux_1,1,'first'):find(aux_1,1,'last'));
    middle_2=aux_2(find(aux_1,1,'first'):find(aux_1,1,'last'));
    clear z3
    % z3(:,1)=([[-r_int:(r_int+joint(1,1))/10:joint(1,1)],middle,[(joint(1,2):(r_int-joint(1,2))/10:r_int)]])';
    % z3(:,2)=([-sqrt(r_int^2-[-r_int:(r_int+joint(1,1))/10:joint(1,1)] .^2),middle_2,-sqrt(r_int^2- [(joint(1,2):(r_int-joint(1,2))/10:r_int)].^2)])';
    z3(:,1)=[joint(1,1),middle,joint(1,2)]';
    z3(:,2)=[joint(2,1),middle_2,joint(2,2)]';
    m_z=diff(z(:,2))./diff(z(:,1));

else 
    aux_1=[(z_prev(:,1)>joint(1,1)).*(z_prev(:,1)<joint(1,2)).*z_prev(:,1)]';
    aux_2=[(z_prev(:,1)>joint(1,1)).*(z_prev(:,1)<joint(1,2)).*z_prev(:,2)]';

    middle=aux_1(find(aux_1,1,'first'):find(aux_1,1,'last'));
    middle_2=aux_2(find(aux_1,1,'first'):find(aux_1,1,'last'));

    z3(:,1)=([[-r_int:(r_int+joint(1,1))/10:joint(1,1)],middle,[(joint(1,2):(r_int-joint(1,2))/10:r_int)]])';
    z3(:,2)=([sqrt(r_int^2-[-r_int:(r_int+joint(1,1))/10:joint(1,1)] .^2),middle_2,sqrt(r_int^2- [(joint(1,2):(r_int-joint(1,2))/10:r_int)].^2)])';
    m_z=diff(z(:,2))./diff(z(:,1));
end


plot_bspline(z3)

end
