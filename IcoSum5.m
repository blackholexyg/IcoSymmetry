function [sum]= IcoSum5(a,X)

theta  = X(:,1);
lambda = X(:,2);


% 5 terms
sum = a(1)*T_00(theta,lambda) + a(2)*T_60(theta,lambda) ...
    + a(3)*T_100(theta,lambda) + a(4)*T_120(theta,lambda) ...
    + a(5)*T_150(theta,lambda);

sum = sqrt(4*pi) * sum;

end
