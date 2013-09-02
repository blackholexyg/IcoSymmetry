function [ savefile ] = SHReadVtk(projectroot,filename,sourcedir,destinationdir)
%ICOREADVTK Read coordinates and triangular meshes from vtk files
% input: projectroot,filename,sourcedir,destinationdir,postfix
% output: savefile


inpath = [projectroot sourcedir '/'];
infile = [filename '.vtk'];
outpath = [projectroot destinationdir '/'];
outfile = [filename '_' destinationdir];

% Read Coordinates from VTK files

% open file
fid=fopen([inpath infile],'r');

% read first 4 lines
info_version=fgetl(fid); %#ok<NASGU>
info_format=fgetl(fid); %#ok<NASGU>
info_encoding=fgetl(fid); %#ok<NASGU>
info_title=fgetl(fid); %#ok<NASGU>

% Nodes
C=textscan(fid,'%s%d%s',1);
NUM_NODES=C{2};

C=textscan(fid,'%f%f%f',NUM_NODES);
x=C{1};
y=C{2};
z=C{3};

% Triangular meshes
C=textscan(fid,'%s%d%s',1);
NUM_TRI=C{2};

C=textscan(fid,'%d%d%d%d',NUM_TRI);
TRI =[C{2} C{3} C{4}]; %#ok<NASGU>

fclose(fid);

% from cartesian coordinates to spherical coordinates
% r2=sqrt(x.*x+y.*y+z.*z);
% fuck this [theta,lambda,r]=cart2sph(x,y,z);

r=zeros(NUM_NODES,1);
theta=zeros(NUM_NODES,1);
lambda=zeros(NUM_NODES,1);

for i=1:NUM_NODES
    r(i)=sqrt(x(i)^2+y(i)^2+z(i)^2);
    theta(i)=atan(sqrt(x(i)^2+y(i)^2)/z(i));
    if theta(i)<0
        theta(i)=pi+theta(i);
    end
    lambda(i)=atan2(y(i),x(i));
    if lambda(i)<0
        lambda(i)=2*pi+lambda(i);
    end
end

% save files
if ~(exist(outpath,'dir')==7)
    mkdir(outpath) 
end

savefile=[ outpath outfile];
save(savefile,'NUM_NODES','x','y','z','r','theta','lambda','NUM_TRI','TRI');

end