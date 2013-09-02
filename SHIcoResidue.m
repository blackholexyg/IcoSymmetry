function [res]= SHIcoResidue(coordfile,a)

load(coordfile);

fit_r1=zeros(size(r));
fit_r2=zeros(size(r));
fit_r3=zeros(size(r));
fit_r4=zeros(size(r));
% fit_r5=zeros(size(r));

for i=1:NUM_NODES
    fit_r1(i) = a(1)*T_00(theta(i),lambda(i));
    
    fit_r2(i) = a(1)*T_00(theta(i),lambda(i)) ...
        + a(2)*T_60(theta(i),lambda(i));
    
    fit_r3(i) = a(1)*T_00(theta(i),lambda(i)) ...
        + a(2)*T_60(theta(i),lambda(i)) ...
        + a(3)*T_100(theta(i),lambda(i));
        
    fit_r4(i) = a(1)*T_00(theta(i),lambda(i)) ...
        + a(2)*T_60(theta(i),lambda(i)) ...
        + a(3)*T_100(theta(i),lambda(i)) ...
        + a(4)*T_120(theta(i),lambda(i));
    
%     fit_r5(i) = a(1)*T_00(theta(i),lambda(i)) ...
%         + a(2)*T_60(theta(i),lambda(i)) ...
%         + a(3)*T_100(theta(i),lambda(i)) ...
%         + a(4)*T_120(theta(i),lambda(i)) ...
%         + a(5)*T_150(theta(i),lambda(i));
end

fit_r1=fit_r1*sqrt(4*pi);
fit_r2=fit_r2*sqrt(4*pi);
fit_r3=fit_r3*sqrt(4*pi);
fit_r4=fit_r4*sqrt(4*pi);
% fit_r5=fit_r5*sqrt(4*pi);

res=zeros(4,1);
res(1) = mean( (r-fit_r1).^2 );
res(2) = mean( (r-fit_r2).^2 );
res(3) = mean( (r-fit_r3).^2 );
res(4) = mean( (r-fit_r4).^2 );
% res(5) = mean( (r-fit_r5).^2 );

end