function pv=fun_subplot_position(nrow,ncolumn,dx,dy,istest,x0,y0)
% This function is used to calculate the customized position vectors 'pv'
% for the Matlab function: subplot('Position',pv)
%
% nrow: number of rows
% ncolumn: number of columns
% dx: horizontal distance between two subplots (Default: 0.1)
% dy: vertical distance between two subplots (Default: 0.1)
% istest: draw the plot for check or not? (1: check, Default: 0) 
% x0: horizontal margin (Default: 0.05)  
% y0: vertical margin (Default: 0.08) 
%
% Example:
% 
% pv = fun_subplot_position(2,2,0.1,0.1,1,0.05,0.05)
%
if nargin<7
    if nargin==2
        dx=0.1;
        dy=0.1;
        istest=0;
        x0=0.05;
        y0=0.08;
    elseif nargin==3
        dy=0.1;
        istest=0;
        x0=0.05;
        y0=0.08;
    elseif nargin==4
        istest=0;
        x0=0.05;
        y0=0.08;
    elseif nargin==5
        x0=0.05;
        y0=0.08;
    else
        y0=0.08;
    end
end
subplot_width=(1-2*x0-(ncolumn-1)*dx)/ncolumn;
subplot_height=(1-2*y0-(nrow-1)*dy)/nrow;
ct=1;
for nr=1:nrow
    for nc=1:ncolumn
        pv(ct,:)=[x0+(nc-1)*(subplot_width+dx) 1-(y0+nr*subplot_height+(nr-1)*dy) subplot_width subplot_height];
        ct=ct+1;
    end
end

if istest==1
    ntotal=nrow*ncolumn;
    for k=1:ntotal
        figure(1)
        subplot('Position',pv(k,:));plot([-1:1],[-1:1]);
    end
end
