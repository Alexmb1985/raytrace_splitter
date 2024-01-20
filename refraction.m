function a_out=refraction(n1,n2,a_r,a_c)
% a_r ->Angulo rayo medido desde el eje x positivo
% a_c ->pendiente de la curva
 a_n=mod(a_c+90+180*(abs(a_r-a_c-90)>90)*(abs(a_r-a_c-90)<270), 360); %normal angle
 a_in=asind(sind(a_r-a_n)); %angulo de incidencia


 a_out(1)=mod((asind(sind(a_in)*n1/n2)+a_n+180)*(abs(sind(a_in))<=(n2/n1))+(2*a_n-a_r)*(abs(sind(a_in))>(n2/n1)),360); %Angulo de salida
 a_out(2)=(abs(sind(a_in))>(n2/n1))*1; %variable para saber si hay cambio de medio
 a_out(3)=a_in;


end