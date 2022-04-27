function fun_errorbarchart(dat_x,dat_y1,dat_y2,test_pval0,title_str,x_lab_str,y_lab_str,legend_str1,legend_str2,star_ypos,plot_pos)
% This function is used to compare two input data in the bar chart and
% error-bar,the statistical test results are shown at the same time.
%
% dat_x: 1 x N   (N: num. of dim.)
% dat_y1: M x N  (M: num. of samples)
% dat_y2: M x N
% test_pval0: 
% 1) Calculate by yourself:
%    test_pval0: 1 x N (statistical test results between two samples:
%    dat_y1 and dat_y2)
% 2) Calculate by this function:
%    test_pval0: 1 (Calculate the paired t-test result (tail: both))
%                2 (Calculate the independent t-test result (tail: both))
%                3 (Calculate the signrank test result (tail: both))
%
% title_str: string (title of the plot)
% x_lab_str: string (x-label)
% y_lab_str: string (y-label)
% legend_str1: string (legend of the dat_y1)
% legend_str2: string (legend of the dat_y2)
% star_ypos: the ceiling position of the statistical results
% plot_pos: the position of the plot (1 x 4)
%
% Example
%
% M=10;N=4;dat_x=[1:N];dat_y1=rand(M,N);dat_y2=rand(M,N);
% title_str='y1 vs y2';
% x_lab_str='Num. of testings';
% y_lab_str='Score';
% legend_str1='y1';legend_str2='y2';
% test_pval0=1;
% fun_errorbarchart(dat_x,dat_y1,dat_y2,test_pval0,title_str,x_lab_str,y_lab_str,legend_str1,legend_str2)


if nargin<9
    disp('Not enough arguments!');
elseif nargin==9
    star_ypos = max([mean(dat_y1,1) mean(dat_y2,1)])*1.05;
    is_plot_default=1;
elseif nargin==10
    is_plot_default=1;    
else
end

dat_mu(1,:)=mean(dat_y1,1);
dat_mu(2,:)=mean(dat_y2,1);
dat_sd(1,:)=std(dat_y1)/sqrt(size(dat_y1,1));
dat_sd(2,:)=std(dat_y2)/sqrt(size(dat_y2,1));

font_size=30;
color_code='rb';
dx=dat_x(2)-dat_x(1);
delta_x=[-0.15 0.15]*dx;
[d1,d2]=size(dat_mu);

if size(test_pval0,2)==size(dat_mu,2)
    test_pval=test_pval0;
else
    test_pval=ones(1,size(dat_mu,2))*(-1);
    for k=1:size(dat_x,2)
        switch test_pval0
            case 1
                [h,test_pval(k)] = ttest(dat_y1(:,k),dat_y2(:,k),'tail','both');
            case 2
                [h,test_pval(k)] = ttest2(dat_y1(:,k),dat_y2(:,k),'tail','both');
            case 3
                [test_pval(k),h] = signrank(dat_y1(:,k),dat_y2(:,k),'tail','both');
            otherwise
        end
    end
end


if d1==2
    if is_plot_default==1
        figure('name','barchart');
    elseif is_plot_default==0
        subplot('Position',plot_pos);
    else
    end
    b=bar(dat_x',dat_mu',1.0);hold on;
    
    for m=1:2
        b(m).LineWidth = 2;
        b(m).FaceColor = color_code(m);
        eb=errorbar(dat_x+delta_x(m),dat_mu(m,:),dat_sd(m,:));hold on;
        eb.LineStyle = 'None';
        eb.LineWidth = 2;
        eb.Color = 'k';
    end
    for n=1:size(dat_x,2)
        if test_pval(n)<0.001
            plot(dat_x(n)-delta_x,star_ypos,'p','markersize',10,'MarkerFaceColor','k','MarkerEdgeColor','k');
            plot(dat_x(n),star_ypos,'p','markersize',10,'MarkerFaceColor','k','MarkerEdgeColor','k');
            plot(dat_x(n)+delta_x,star_ypos,'p','markersize',10,'MarkerFaceColor','k','MarkerEdgeColor','k');
            
        elseif test_pval(n)<0.01
            plot(dat_x(n)-delta_x,star_ypos,'p','markersize',10,'MarkerFaceColor','k','MarkerEdgeColor','k');
            plot(dat_x(n)+delta_x,star_ypos,'p','markersize',10,'MarkerFaceColor','k','MarkerEdgeColor','k');
            
        elseif test_pval(n)<0.05
            plot(dat_x(n),star_ypos,'p','markersize',10,'MarkerFaceColor','k','MarkerEdgeColor','k');
        else
        end
    end
    legend(legend_str1,legend_str2,'location','southeast');
    title([title_str]);
    xlabel(x_lab_str);
    ylabel(y_lab_str);
    xticks(dat_x);
    xlim([dat_x(1)-(dx/2) dat_x(end)+(dx/2)]);
    ylim([0 star_ypos*1.1]);
    set(gca,'fontsize',font_size,'linewidth',2);
else
    disp('check the dimension of input');
end
