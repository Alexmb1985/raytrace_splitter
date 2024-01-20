%% trazado rayos
clear all; clc;
n_punto=21;
z_aux=zeros(n_punto,2);%coordenadas x e y de cada punto de la curva concentradora, en principio consideramos 31 puntos
z_aux(:,1)=-30:30/(n_punto-1):0; %x
%% BK7 Water 10x
  z_aux(:,2)=[0	-1.83	-0.18	0.42	0.77	0.63	0.26	-0.09	-0.57	-1.08	-2.06	-2.72	-3.7	-4.32	-5.73	-6.27	-6.98	-8	-9.52	-10.32	-11.82]';

%% VALORES DE ENTRADA
l_cil=10;%mm longitud célula
Radius=30;%Radio del cilindro exterior mm
r_ext=30;
r_int=28;
y0 = Radius*2; % Cordenada de posición de la fuente de luz
x0Max = Radius;% Ancho de la fuente de luz

% Grid,
NRays =500;%Numeros de rayos
NRays_z=1;%Numero de rayos eje z
n_div_z=NRays_z; %nº de divisones eje z
n_div=50; %nºdivisiones celula coordenada x
ray=(2*Radius*l_cil)/(NRays*NRays_z*1000000);  %Espacio ocupado por cada rayo metros^2, el 1000000 pasa de mm2 a m2

int=50;


r_cell=-27.839; 
t_cell=6;

% 
n1=1; %Índice de refracción del aire
 

lambda=500;
%% LECTURA DE DATOS ARCHIVOS:
n_k_pmma=csvread('n_k_bk7.csv'); %Columns: 1-wavelengths(nm), 2-n, 3-k

n_pmma=interp1(n_k_pmma(:,1),n_k_pmma(:,2),lambda);

k_pmma=interp1(n_k_pmma(:,1),n_k_pmma(:,3),lambda);
clear n_k_pmma;


n_k_dielectric=csvread('n_k_water_.csv'); %Columns: 1-wavelengths(um), 2-n, 3-k
n_k_dielectric(:,1)=1000*n_k_dielectric(:,1); %um to nm
n_dielectric=interp1(n_k_dielectric(:,1),n_k_dielectric(:,2),lambda);
k_dielectric=interp1(n_k_dielectric(:,1),n_k_dielectric(:,3),lambda);

clear n_k_dielectric;


%% DEFINICIÓN CURVAS

cell=[-t_cell/2, r_cell; t_cell/2, r_cell];
circ_1=zeros(length(-30:0.001:30),2);
circ_1(:,1)=-30:0.001:30;
circ_1(:,2)=sqrt(r_ext^2-(-30:0.001:30).^2);
m_circ_1=diff(circ_1(:,2))./diff(circ_1(:,1));

circ_2=zeros(length(-30:0.001:30),2);
circ_2(:,1)=-30:0.001:30;
circ_2(:,2)=-sqrt(r_ext^2-(-30:0.001:30).^2);
m_circ_2=diff(circ_2(:,2))./diff(circ_2(:,1));

circ_3=zeros(length(-28:0.001:28),2);
circ_3(:,1)=-28:0.001:28;
circ_3(:,2)=-sqrt(r_int^2-(-28:0.001:28).^2);
m_circ_3=diff(circ_3(:,2))./diff(circ_3(:,1));

figure;
hold all;



z_prev1(:,1)=[z_aux(:,1);flipud(-z_aux(1:20,1))];
z_prev1(:,2)=[z_aux(:,2);flipud(z_aux(1:20,2))];

z_prev=interp_bspline(z_prev1);


joint=InterX([z_prev(:,1)';z_prev(:,2)'],[circ_3(:,1)';-circ_3(:,2)']);
if isempty(joint)
joint=InterX([z_prev(:,1)';z_prev(:,2)'],[circ_3(:,1)';circ_3(:,2)']);   

aux_1=[(z_prev(:,1)>joint(1,1)).*(z_prev(:,1)<joint(1,2)).*z_prev(:,1)]';
aux_2=[(z_prev(:,1)>joint(1,1)).*(z_prev(:,1)<joint(1,2)).*z_prev(:,2)]';

middle=aux_1(find(aux_1,1,'first'):find(aux_1,1,'last'));
middle_2=aux_2(find(aux_1,1,'first'):find(aux_1,1,'last'));

z(:,1)=([[-r_int:(r_int+joint(1,1))/10:joint(1,1)],middle,[(joint(1,2):(r_int-joint(1,2))/10:r_int)]])';
z(:,2)=([-sqrt(r_int^2-[-r_int:(r_int+joint(1,1))/10:joint(1,1)] .^2),middle_2,-sqrt(r_int^2- [(joint(1,2):(r_int-joint(1,2))/10:r_int)].^2)])';
m_z=diff(z(:,2))./diff(z(:,1));

else 
    aux_1=[(z_prev(:,1)>joint(1,1)).*(z_prev(:,1)<joint(1,2)).*z_prev(:,1)]';
aux_2=[(z_prev(:,1)>joint(1,1)).*(z_prev(:,1)<joint(1,2)).*z_prev(:,2)]';

middle=aux_1(find(aux_1,1,'first'):find(aux_1,1,'last'));
middle_2=aux_2(find(aux_1,1,'first'):find(aux_1,1,'last'));

z(:,1)=([[-r_int:(r_int+joint(1,1))/10:joint(1,1)],middle,[(joint(1,2):(r_int-joint(1,2))/10:r_int)]])';
z(:,2)=([sqrt(r_int^2-[-r_int:(r_int+joint(1,1))/10:joint(1,1)] .^2),middle_2,sqrt(r_int^2- [(joint(1,2):(r_int-joint(1,2))/10:r_int)].^2)])';
m_z=diff(z(:,2))./diff(z(:,1));
end


%% Trazado

    y1=sqrt(r_ext^2-(-30:0.1:30).^2);
    y2=-sqrt(r_ext^2-(-30:0.1:30).^2);
    
    X=[-30:0.1:30,fliplr(-30:0.1:30)];
    Y=[y1,fliplr(y2)];              %#create y values for out and then back
    fill(X,Y,[0.97  0.97  0.97] );  


    y1=middle_2;
    y2=-sqrt(r_int^2-(joint(1,1):0.01:joint(1,2)).^2);

    X=[middle,fliplr(joint(1,1):0.01:joint(1,2))];
    Y=[y1,fliplr(y2)];              %#create y values for out and then back
    fill(X,Y,[0.78  0.92  1] );     
    

    
    

plot(cell(:,1),cell(:,2),'k','LineWidth',1.1);
plot(-30:0.1:30,sqrt(r_ext^2-(-30:0.1:30).^2),'k','LineWidth',1.1);
plot(-30:0.1:30,-sqrt(r_ext^2-(-30:0.1:30).^2),'k','LineWidth',1.1);
plot(joint(1,1):0.01:joint(1,2),-sqrt(r_int^2-(joint(1,1):0.01:joint(1,2)).^2),'k','LineWidth',1.1);
xlim([-35 35]);
ylim([-35 35]);
 

for x=([-28.8:1:-0.8,0.8:1:28.8])
  y=35;  
  a_r=270;

stop=0;
n1=1;
n2=1;

i=0;
sup_ant=0;
sup_new=0;
reflex_tot=0;


while stop==0  
    n1=n2*(reflex_tot==0)+n1*reflex_tot;
    sup_ant=sup_new;
    i=i+1;
    
    x_old=x;
    y_old=y;

    pos=next_impact(x,y,a_r,r_ext,r_int,cell,circ_1,m_circ_1,circ_2,m_circ_2,circ_3,m_circ_3,z,m_z);
    x=pos(1);
    y=pos(2);
    stop=pos(4);
    m=pos(5);
    sup_new=pos(6);

    if (sup_new==1) || (sup_new==4)
        n2=n_dielectric*(n1==n_pmma)+n_pmma*(n1==n_dielectric);
        elseif (sup_new==2) || (sup_new==3)
            n2=1*(n1==n_pmma)+n_pmma*(n1==1);
    end
   
    
    atand(m);

    a_out=refraction(n1,n2,mod(a_r+180,360),atand(m));
    reflex_tot=a_out(2);
    a_r=a_out(1);
        if (reflex_tot==1) && (n2>n1)
            disp('error')
        end
     
     plot([x_old;x],[y_old;y],'b');

end
 
end


x0=10;
y0=10;
width=350;
height=350;
set(gcf,'units','points','position',[x0,y0,width,height])

pbaspect([1 1 1]);
