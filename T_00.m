function [result]=T_00(theta, phi)

b_00=1;
normalize= sqrt(4*pi);

theta=reshape(theta,1,[]);
phi=reshape(phi,1,[]);

P_0M=legendre(0,cos(phi));
P_00=P_0M(0+1,:);
      
result=b_00*P_00;
result=result/normalize;

result = reshape(result, [],1);

end