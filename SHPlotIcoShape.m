% SPH Plot
clc,clear;

resolution = 500;

% discretize sphere surface
delta = pi/resolution;
theta = 0:delta:pi; % altitude
phi = 0:2*delta:2*pi; % azimuth
[phi,theta] = meshgrid(phi,theta);
r=zeros(size(phi));

for i=1:size( phi, 1)
  for j=1:size( phi, 2)
      r(i,j)= T_120(theta(i,j), phi(i,j));
  end
end

r2=r+2*max(max( abs(r) ));

%%
x = abs(r2).*sin(theta).*cos(phi); 
y = abs(r2).*sin(theta).*sin(phi);
z = abs(r2).*cos(theta);

% set figure background to white
figure('Color',[1 1 1],'renderer','zbuffer','Position', [1, 100, 480, 480]);
hold on;

% visualization
h = surf(x,y,z);
axis equal;
	
% adjust camera view
view(40,30)
camzoom(2.8)
camlight left
camlight right
% lighting phong

set(h, 'LineStyle','none')
grid off
axis off