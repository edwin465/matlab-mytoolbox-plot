# matlab-mytoolbox-plot
通過對matlab畫圖函數進行二次開發，以便可以快速和簡單地展示一些計算結果。  
我在這裏分享三個我編寫的函數：`fun_subplot_position()`，`fun_errorbarchart()`和`fun_barchart_errorbar_plot()`

## fun_subplot_position
使用Matlab自帶的subplot()，不同subplot之間的默認距離有時候會覺得太大，使得繪圖内容顯得有點小，不利於觀看結果;
使用這個`fun_subplot_position()`函數，可以設置subplot之間的距離，然後自動計算subplot函數的position vector，使不同subplot之間的結果集中一些。

### How to use `fun_subplot_position()`?
```
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
```  

```
>> pv = fun_subplot_position(2,2,0.1,0.1,1,0.05,0.05)  

pv =

    0.0500    0.5500    0.4000    0.4000
    0.5500    0.5500    0.4000    0.4000
    0.0500    0.0500    0.4000    0.4000
    0.5500    0.0500    0.4000    0.4000
```

The corresponding plot is shown below:  
![result1](https://github.com/edwin465/matlab-mytoolbox-plot/blob/main/fun_subplot_position_plot.png)

If we use `subplot()` to plot the results, then we would get the following plot:
![result2](https://github.com/edwin465/matlab-mytoolbox-plot/blob/main/subplot_plot.png)

The horizontal margin is too large in the second figure. If we use this figure in the manuscript, the main result would be too small in some cases. Then, it is usually suggested to remove the margin.  

Hence, it is recommended to use the `fun_subplot_position()` to customize the position of each subplot (as shown in the first figure). Then there is no need to remove the margin anymore.

## fun_errorbarchart and fun_barchart_errorbar_plot
在科技文章，比較不同算法結果之間的差異是經常遇到的事情，我們可以使用Matlab的errorbar圖、bar圖和統計檢驗的方法去比較他們的差異，可惜的是，Matlab沒有一個可以同時把這些内容繪畫出來的函數；
因此，我編寫了下面兩個函數`fun_errorbarchart()`和`fun_barchart_errorbar_plot()`去完成這個任務，

### How to use `fun_errorbarchart()`?  
```
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
```

```
M=10;N=4;dat_x=[1:N];dat_y1=rand(M,N);dat_y2=rand(M,N);     
title_str='y1 vs y2';       
x_lab_str='Num. of testings';       
y_lab_str='Score';  
legend_str1='y1';legend_str2='y2';  
test_pval0=1;  
fun_errorbarchart(dat_x,dat_y1,dat_y2,test_pval0,title_str,x_lab_str,y_lab_str,legend_str1,legend_str2)  
```  

The corresponding plot is shown below (P.S. the data is randomly generated, so this example outputs different plot everytime)
![result3](https://github.com/edwin465/matlab-mytoolbox-plot/blob/main/fun_errorbarchart_plot.png)

### How to use `fun_barchart_errorbar_plot()`?
```
function fun_barchart_errorbar_plot(data, N1,N2,color_rgb,title_str,x_lab_str,y_lab_str,legend_str,x_tick_str)  

% data: M x (N1xN2)   
% data = [A1 A2 A3 ... A_N1], A_i: M x N2    
% M: num. of subjects/samples/repetitons (for average),  
% N1: num. of algorithms (num. of bars in barchart), 1<=N1<=6  
% N2: num. of data lengths/time-window lengths (xticks in barchart)  
% color_rgb: bar color (RGB)  
% title_str: string (title of the plot)  
% x_lab_str: string (x-label)    
% y_lab_str: string (y-label)    
% legend_str: cell string (for legend())    
% x_tick_str: cell string (for xticklabels())   
```  

```
num_of_sub=12;num_of_method=4;num_of_tw=7;
data=rand(num_of_sub,num_of_method*num_of_tw)*100;
[M,N]=size(data);   
color_rgb=[0 0 0;   
     1 0 0;  
     0 0 1;  
     0 204/255 0;  
     153/255 153/255 0;  
     1 0 1;  
     1 128/255 0;  
     0 128/255 1;  
     0.9 0 0;  
     1 102/255 1;  
     0 1 0];   
title_str='Comparison';  
x_lab_str='TW (s)';  
y_lab_str='Accuracy (%)';  
legend_str={'M1','M2','M3','M4','M5','M6'};  
x_tick_str={'0.5','1.0','1.5','2.0','2.5','3.0','3.5'};  
fun_barchart_errorbar_plot(data,num_of_method,num_of_tw,color_rgb,title_str,x_lab_str,y_lab_str,legend_str(1:num_of_method),x_tick_str);
```  

The corresponding plot is shown below (P.S. the data is randomly generated, so this example outputs different plot everytime)
![result4](https://github.com/edwin465/matlab-mytoolbox-plot/blob/main/fun_barchart_errorbar_plot.png)  
