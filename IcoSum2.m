function [sum]= IcoSum2(a,X)

theta  = X(:,1);
lambda = X(:,2);


% 2 terms
sum = a(1)*T_00(theta,lambda) + a(2)*T_60(theta,lambda); 


sum = sqrt(4*pi) * sum;

end
