function [result]=T_120(theta, phi)

b_120=2^8 * 3^5 * 5^2 * 7^2 * 11 * 17;
b_125=- 2^4 * 3^2 * 5 * 7 * 11;
b_1210=1;
normalize= 2^9 *3^4 *5^4 *sqrt(7*13*19*pi );

theta=reshape(theta,1,[]);
phi=reshape(phi,1,[]);

P_12M=legendre(12,cos(theta));
P_120=P_12M(0+1,:);
P_125=P_12M(5+1,:);
P_1210=P_12M(10+1,:);

result=b_120*P_120 +b_125*P_125 .*cos(5*phi) +b_1210*P_1210 .*cos(10*phi);
result=result/normalize;

result = reshape(result, [],1);

end