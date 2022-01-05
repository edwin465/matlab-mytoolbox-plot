function fun_barchart_errorbar_plot(data, N1,N2,color_rgb,title_str,x_lab_str,y_lab_str,legend_str,x_tick_str)

% data: M x (N1xN2) 
% data = [A1 A2 A3 ... A_N1], A_i: M x N2

% M: num. of subjects/samples/repetitons (for average),
% N1: num. of algorithms (num. of bars in barchart), 1<=N1<=6
% N2: num. of data lengths/time-window lengths (xticks in barchart)
% color_rgb: bar color (RGB)

% Example:
% num_of_sub=12;
% num_of_method=4;
% num_of_tw=7;
% data=rand(num_of_sub,num_of_method*num_of_tw)*100;
% [M,N]=size(data);
% color_rgb=[0 0 0;
%     1 0 0;
%     0 0 1;
%     0 204/255 0;
%     153/255 153/255 0;
%     1 0 1;
%     1 128/255 0;
%     0 128/255 1;
%     0.9 0 0;
%     1 102/255 1;
%     0 1 0]; 
% title_str='Comparison';
% x_lab_str='TW (s)';
% y_lab_str='Accuracy (%)';
% legend_str={'M1','M2','M3','M4','M5','M6'};
% x_tick_str={'0.5','1.0','1.5','2.0','2.5','3.0','3.5'};
% fun_barchart_errorbar_plot(data,num_of_method,num_of_tw,color_rgb,title_str,x_lab_str,y_lab_str,legend_str(1:num_of_method),x_tick_str);

font_size=30;
[M,N]=size(data);

if nargin<=1
    disp('Not enough arguments!');
elseif nargin==2
    if mod(N,N1)==0
        N2=floor(N/N1);
    else
        disp('N1 is not correct!');
    end
elseif nargin==3
    if N==N1*N2        
    else
        disp('N is not equal to N1 x N2!');
    end
else
end

data_x=[1:N2];
mu=mean(data,1);
se=std(data)/sqrt(M);
dx=data_x(2)-data_x(1);
if N1==2
    delta_x=[-0.15 0.15]*dx;
    cap_size=16;
elseif N1==3
    delta_x=[-0.2 0 0.2]*dx;
    cap_size=15;
elseif N1==4
    delta_x=[-0.26 -0.09 0.09 0.26]*dx;
    cap_size=15;
elseif N1==5
    delta_x=[-0.31 -0.15 0 0.15 0.31]*dx;
    cap_size=14;
else
    delta_x=[-0.335 -0.195 -0.07 0.07 0.195 0.335]*dx;
    cap_size=12;
end

for k=1:N1
    data_mu(k,:)=mu((k-1)*N2+1:k*N2);
    data_se(k,:)=se((k-1)*N2+1:k*N2);
end

b=bar(data_x',data_mu',1.0);hold on;
for m=1:N1
    b(m).FaceColor = color_rgb(m,:);
    b(m).EdgeColor = color_rgb(m,:);
    eb=errorbar(data_x+delta_x(m),data_mu(m,:),data_se(m,:));hold on;
    eb.LineStyle = 'None';
    eb.LineWidth = 2;
    eb.Color = color_rgb(m,:);
    eb.CapSize = cap_size;
end
xlim([0.2 N2+0.8]); 
ylim([0 (max(data_mu(:))+max(data_se(:)))*1.1]);
legend(legend_str,'location','southeast');
title([title_str]);
xlabel(x_lab_str);
ylabel(y_lab_str);
xticks(data_x);
xticklabels(x_tick_str)    
set(gca,'fontsize',font_size,'linewidth',2);