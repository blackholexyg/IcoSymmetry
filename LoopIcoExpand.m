% Icosahedral Harmonics Expansion

%% Basic Settings
clc;clear;

projectroot='../Data/FinalTest/';

% get filelist
fid=fopen( [projectroot 'filelist.txt']);
% fid=fopen( ['filelist.txt']);

% First line contains number of files to be processed
tline = fgetl(fid);
filenum = str2double(tline);

filelist =cell(filenum,1);

% scan file name list
for num=1:filenum
    filelist{num}= fgetl(fid);
end

fclose(fid);

%% Main Loop

% Define some result variables

outpath=[ projectroot 'icoexpand/' ];
if ~(exist(outpath,'dir')==7)
    mkdir(outpath)
end

% Processing Loop
for num = 1:length(filelist)
    filename=filelist{num} ;
    disp([ 'Processing: ' filename ])
    %    Loop operations
    try
        
        %  Preprocessing:
        coordfile = SHReadVtk(projectroot,filename,'vtk','orginal');
        
        % Icohedral Harmonics Expansion 
        
        a = SHIcoExpand(coordfile);
        
        % Residue:
        
        res_expand = SHIcoResidue(coordfile, a);
        
        % save results
        outfile= [filename '_icoexpand' '.mat'];
        savefile=[outpath outfile];
        save( savefile ,'a','res_expand');
        
    catch MYERROR
        
        disp( MYERROR )
        disp( ['missing: ' filename])
        
    end
   
end

%% Results or Plots

% outfile= ['Results' '.mat'];
% savefile=[outpath outfile];
% save( savefile ,'');

