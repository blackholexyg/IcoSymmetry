function [ res] = SHRealResidue(coordfile, Cnm,Snm)
%SHREALRESIDUE Summary of this function goes here
%   Detailed explanation goes here

load(coordfile);

sum=zeros(size(theta));

for i=1:NUM_NODES
    
    m=0;
    n=0;

    for k=1:length(Cnm)
        
        sum(i)=sum(i)+( Cnm(k)*cos(m*lambda(i)) + Snm(k)*sin(m*lambda(i) ) )*SHPnm(n,m,theta(i) ) ;
        
        if n==m
            n=n+1;
            m=0;
        elseif n>m
            m=m+1;
        end
        
    end
    
end

res = mean( (r-sum).^2 );


end