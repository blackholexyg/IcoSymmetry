function [ Ylm ]= SHYlm(l,m,theta,phi)

Pn=legendre(l,cos(theta));


C= sqrt( (2*l+1)/(4*pi) * factorial(l- abs(m) )/factorial(l+abs(m)) );
Ylm_plus= C * Pn(abs(m)+1) * exp( 1i*abs(m)*phi);

if m>=0
    Ylm=Ylm_plus;
else
    Ylm=(-1)^ abs(m) * factorial(l-abs(m))/factorial(l+abs(m) ) * Ylm_plus;
end


end