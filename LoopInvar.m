% Calculate Rotational Invariants

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

outpath=[ projectroot 'invariants/' ];
if ~(exist(outpath,'dir')==7)
    mkdir(outpath)
end

Qlm_0_invar=zeros(length(filelist),1);
Qlm_6_invar=zeros(length(filelist),1);
Qlm_10_invar=zeros(length(filelist),1);

% Processing Loop
for num = 1:length(filelist)
    filename=filelist{num} ;
    disp([ 'Processing: ' filename ])
    %    Loop operations
    try
        
        %  Preprocessing:
        coordfile = SHReadVtk(projectroot,filename,'vtk','orginal');
        
        % Complex Expansion        
        Qlm_0 = SHComplexExpandL(coordfile,0);
        Qlm_6 = SHComplexExpandL(coordfile,6);
        Qlm_10 = SHComplexExpandL(coordfile,10);

        Qlm_0_invar(num)=0;
        for m=1:(2*0+1)
            Qlm_0_invar(num)=Qlm_0_invar(num)+4*pi/(2*0+1)*abs(Qlm_0(m))^2;
        end
        
        Qlm_6_invar(num)=0;
        for m=1:(2*6+1)
            Qlm_6_invar(num)=Qlm_6_invar(num)+4*pi/(2*6+1)*abs(Qlm_6(m))^2;
        end
        
        Qlm_10_invar(num)=0;
        for m=1:(2*10+1)
            Qlm_10_invar(num)=Qlm_10_invar(num)+4*pi/(2*10+1)*abs(Qlm_10(m))^2;
        end

        % save results
        outfile= [filename '_expancomplex' '.mat'];
        savefile=[outpath outfile];
        save( savefile ,'Qlm_0','Qlm_6','Qlm_10');
        
    catch MYERROR
        
        disp( MYERROR )
        disp( ['missing: ' filename])
        
    end
   
end

outfile= ['Results' '.mat'];
savefile=[outpath outfile];
save( savefile ,'Qlm_0_invar','Qlm_6_invar','Qlm_10_invar');


%% Results or Plots
%
% format long
% Y_plot1
% Y_plot2
%
% 
% Plot for each file
% % for k=1:length(filelist)
%     k=2
%     h=figure(k);
%     hold on
% 
%     plot(1:5,Y_plot(k,:),'b*-');
%     title('Convergence Test')
    % print(h,'-dpng',[ '../' 'Convergence_' filelist{k} '.png'])
    % axis([1 5 0e-3 1e-3])
    % print(h,'-dpng',[ '../' 'N_Convergence_' filelist{k} '.png'])
    
    % close(h);
% end
%
% Plot Trend
% 
% figure(1);
% plot(1:length(filelist),Qlm_0_invar,'b*-');
% title('|Q_0|^2 ')
% figure(2);
% plot(1:length(filelist),Qlm_6_invar,'b*-');
% title('|Q_6|^2 ')
% figure(3);
% plot(1:length(filelist),Qlm_10_invar,'b*-');
% title('|Q_1_0|^2 ')

