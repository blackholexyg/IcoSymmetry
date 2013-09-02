% Icosahedral Harmonics Fitting

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

outpath=[ projectroot 'icofit/' ];
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

        load(coordfile);
        
        lb=[];
        ub=[];
        
        ff=optimset;
        ff.MaxFunEvals=50000;
        ff.MaxIter=5000;
        ff.TolFun=1e-10;
        ff.Algorithm='';
        
        Xdata=[theta,lambda];
        Ydata=r;
        
        res_fit=zeros(5,1);
        
        a0_1=zeros(1,1);
        [a_fit_1,resnorm,~] = lsqcurvefit(@IcoSum1,a0_1,Xdata,Ydata,lb,ub,ff);
        res_fit(1)= resnorm/ length(Ydata);
        
        a0_2=zeros(2,1);
        a0_2(1:length(a0_1))=a0_1;
        [a_fit_2,resnorm,~] = lsqcurvefit(@IcoSum2,a0_2,Xdata,Ydata,lb,ub,ff);
        res_fit(2)= resnorm/ length(Ydata);
        
        a0_3=zeros(3,1);
        a0_3(1:length(a0_2))=a0_2;
        [a_fit_3,resnorm,~] = lsqcurvefit(@IcoSum3,a0_3,Xdata,Ydata,lb,ub,ff);
        res_fit(3)= resnorm/ length(Ydata);
        
        a0_4=zeros(4,1);
        a0_4(1:length(a0_3))=a0_3;
        [a_fit_4,resnorm,~] = lsqcurvefit(@IcoSum4,a0_4,Xdata,Ydata,lb,ub,ff);
        res_fit(4)= resnorm/ length(Ydata);
        
        a0_5=zeros(5,1);
        a0_5(1:length(a0_4))=a0_4;
        [a_fit_5,resnorm,~] = lsqcurvefit(@IcoSum5,a0_5,Xdata,Ydata,lb,ub,ff);
        res_fit(5)= resnorm/ length(Ydata);
        
        % save results
        outfile= [filename '_icofit' '.mat'];
        savefile=[outpath outfile];
        save(savefile,'a_fit_1','a_fit_2','a_fit_3','a_fit_4','a_fit_5','res_fit');
        
    catch MYERROR
        
        disp( MYERROR )
        disp( ['missing: ' filename])
        
    end
   
end



%% Results or Plots

% 
% outfile= ['Results' '.mat'];
% savefile=[outpath outfile];
% save( savefile ,'Qlm_0_invar','Qlm_6_invar','Qlm_10_invar');
