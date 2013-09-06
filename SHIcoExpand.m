function [a]= SHIcoExpand(coordfile)
% SHICOEXPAND: To calculate the projection on the icosahedral subspace
%  input: matlab data file name
% output: expand coefficients

load(coordfile);
a = zeros(4,1);

% sum_T=0;
sum_A=0;

sum_T1=0;
sum_T2=0;
sum_T3=0;
sum_T4=0;

for i=1:NUM_TRI
    N1=TRI(i,1)+1;
    N2=TRI(i,2)+1;
    N3=TRI(i,3)+1;
    
    
%     v1=[x(N1)-x(N3),y(N1)-y(N3),z(N1)-z(N3)];
%     v2=[x(N2)-x(N3),y(N2)-y(N3),z(N2)-z(N3)];
%     S=norm(cross(v1,v2))/2;
    
    % the corresponding node on the unit sphere
    x1=sin(theta(N1))*cos(lambda(N1));
    y1=sin(theta(N1))*sin(lambda(N1));
    z1=cos(theta(N1));

    x2=sin(theta(N2))*cos(lambda(N2));
    y2=sin(theta(N2))*sin(lambda(N2));
    z2=cos(theta(N2));
    
    x3=sin(theta(N3))*cos(lambda(N3));
    y3=sin(theta(N3))*sin(lambda(N3));
    z3=cos(theta(N3));
    
    v1=[x1-x3,y1-y3,z1-z3];
    v2=[x2-x3,y2-y3,z2-z3];
    
    S=norm(cross(v1,v2))/2;
    
    sum_A=sum_A+S;

    I1_T1= ( T_00(theta(N1), lambda(N1)) ) * r(1);
    I2_T1= ( T_00(theta(N2), lambda(N2)) ) * r(2);  
    I3_T1= ( T_00(theta(N3), lambda(N3)) ) * r(3);
    
    I1_T2= ( T_60(theta(N1), lambda(N1)) ) * r(1);
    I2_T2= ( T_60(theta(N2), lambda(N2)) ) * r(2);  
    I3_T2= ( T_60(theta(N3), lambda(N3)) ) * r(3);

    I1_T3= ( T_100(theta(N1), lambda(N1)) ) * r(1);
    I2_T3= ( T_100(theta(N2), lambda(N2)) ) * r(2);  
    I3_T3= ( T_100(theta(N3), lambda(N3)) ) * r(3);
    
    I1_T4= ( T_120(theta(N1), lambda(N1)) ) * r(1);
    I2_T4= ( T_120(theta(N2), lambda(N2)) ) * r(2);  
    I3_T4= ( T_120(theta(N3), lambda(N3)) ) * r(3);
    
    sum_T1=sum_T1+( I1_T1+ I2_T1 + I3_T1)*S/3;
    sum_T2=sum_T2+( I1_T2+ I2_T2 + I3_T2)*S/3;
    sum_T3=sum_T3+( I1_T3+ I2_T3 + I3_T3)*S/3;
    sum_T4=sum_T4+( I1_T4+ I2_T4 + I3_T4)*S/3;
            
end

format long

a(1)=sum_T1/(sum_A)* sqrt(4*pi);
a(2)=sum_T2/(sum_A)* sqrt(4*pi);
a(3)=sum_T3/(sum_A)* sqrt(4*pi);
a(4)=sum_T4/(sum_A)* sqrt(4*pi);

end