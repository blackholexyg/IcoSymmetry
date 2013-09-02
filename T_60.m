function [result]=T_60(theta, phi)

b_60=2^3*3^2*5*11;
b_65=-1;
normalize= 3600* sqrt(11*pi/13);

theta=reshape(theta,1,[]);
phi=reshape(phi,1,[]);

P_6M=legendre(6,cos(theta));
P_60=P_6M(0+1,:);
P_65=P_6M(5+1,:);
      
result=b_60*P_60 + b_65*P_65 .*cos(5*phi);
result=result/normalize;

result = reshape(result, [],1);

end