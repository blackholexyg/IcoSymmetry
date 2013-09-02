function [result]=T_100(theta, phi)

b_100=896313600;
b_105=27360;
b_1010=1;
normalize= 25920000* sqrt(1729*pi);

theta=reshape(theta,1,[]);
phi=reshape(phi,1,[]);

P_10M=legendre(10,cos(theta));
P_100=P_10M(0+1,:);
P_105=P_10M(5+1,:);
P_1010=P_10M(10+1,:);
      
result=b_100*P_100 + b_105*P_105 .*cos(5*phi)+ b_1010* P_1010 .*cos(10*phi);
result=result/normalize;

result = reshape(result, [],1);

end