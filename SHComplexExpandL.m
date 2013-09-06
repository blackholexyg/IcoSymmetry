function [Qlm]= SHComplexExpandL(sourcefile,L)
%SHEXPANDYLM To expand by with integration method
% calculate the coefficients for Qlm

load( sourcefile );

% Degrees to be expanded
Qlm=zeros(2*L+1,1);

l=L;

disp( [ '===== Expanding Degree L: ' num2str(l)])

for m=-L:L
    disp( [ '+++++ Expanding Order M: ' num2str(m)])
        
    sum_A=0;
    sum_Q=0;
        
    for i=1:NUM_TRI
        N1=TRI(i,1)+1;
        N2=TRI(i,2)+1;
        N3=TRI(i,3)+1;
        v1=[x(N1)-x(N3),y(N1)-y(N3),z(N1)-z(N3)];
        v2=[x(N2)-x(N3),y(N2)-y(N3),z(N2)-z(N3)];
        S=norm(cross(v1,v2))/2;
        
        sum_A=sum_A+S;
        
        I1_Q=r(N1)*SHYlm(l,m,theta(N1) ,lambda(N1) );
        I2_Q=r(N2)*SHYlm(l,m,theta(N2) ,lambda(N2) );
        I3_Q=r(N3)*SHYlm(l,m,theta(N3) ,lambda(N3) );
        
        sum_Q=sum_Q+( I1_Q+ I2_Q + I3_Q)*S/3;
                        
    end
    
    
    Qlm(m+L+1)=sum_Q/(sum_A);
        
end


Qlm=sqrt(4*pi)*Qlm;

end