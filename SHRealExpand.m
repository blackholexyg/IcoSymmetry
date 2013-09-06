function [Cnm, Snm]= SHRealExpand(coordfile,N)
% Expand by integration
% calculate the coefficients for Cnm and Snm


load(coordfile);

% Degrees to be expanded
Dim=(N+1)*(N)/2;
Cnm=zeros(Dim,1);
Snm=zeros(Dim,1);

k=0;

for n=0:N-1  
    disp( ['-------Expanding: Degree ' num2str(n)  ]);
    for m=0:n
        
        k=k+1;
       
        sum_C=0;
        sum_S=0;
        sum_A=0;
        
        for i=1:NUM_TRI
            N1=TRI(i,1)+1;
            N2=TRI(i,2)+1;
            N3=TRI(i,3)+1;
            
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
            
            I1_C=r(N1)*SHPnm(n,m,theta(N1) )*cos(m*lambda(N1) );
            I2_C=r(N2)*SHPnm(n,m,theta(N2) )*cos(m*lambda(N2) );
            I3_C=r(N3)*SHPnm(n,m,theta(N3) )*cos(m*lambda(N3) );
            
            sum_C=sum_C+( I1_C+ I2_C + I3_C)*S/3;
            
            I1_S=r(N1)*SHPnm(n,m,theta(N1) )*sin(m*lambda(N1) );
            I2_S=r(N2)*SHPnm(n,m,theta(N2) )*sin(m*lambda(N2) );
            I3_S=r(N3)*SHPnm(n,m,theta(N3) )*sin(m*lambda(N3) );
            
            sum_S=sum_S+( I1_S+ I2_S + I3_S)*S/3;
            
        end       
        
        
        Cnm(k)=sum_C/(sum_A);
        Snm(k)=sum_S/(sum_A);
        
    end
end


end