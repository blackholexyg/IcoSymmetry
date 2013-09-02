function [result]=T_120(theta, phi)

b_120=8.257237892937810e-1;
b_125=-3.21243304269289e-6;
b_1210=5.794431895189197e-11;

theta=reshape(theta,1,[]);
phi=reshape(phi,1,[]);

P_12M=legendre(12,cos(theta));
P_120=P_12M(0+1,:);
P_125=P_12M(5+1,:);
P_1210=P_12M(10+1,:);

result=b_120*P_120 +b_125*P_125 .*cos(5*phi) +b_1210*P_1210 .*cos(10*phi);

result = reshape(result, [],1);

end