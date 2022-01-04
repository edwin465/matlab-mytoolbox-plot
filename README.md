# matlab-mytoolbox-plot
通過對matlab畫圖函數進行二次開發，以便可以快速和簡單地展示一些計算結果。  
我在這裏分享兩個我編寫的畫圖函數：`fun_subplot_position()`和`fun_errorbarchart()`

## fun_subplot_position
使用Matlab自帶的subplot()，不同subplot之間的默認距離有時候會覺得太大，使得繪圖内容顯得有點小，不利於觀看結果;
使用這個`fun_subplot_position()`函數，可以設置subplot之間的距離，然後自動計算subplot函數的position vector，使不同subplot之間的結果集中一些。

### How to use `fun_subplot_position()`?
```function pv=fun_subplot_position(nrow,ncolumn,dx,dy,istest,x0,y0)   
% This function is used to calculate the customized position vectors 'pv'  
% for the Matlab function: subplot('Position',pv)  
%  
% nrow: number of rows  
% ncolumn: number of columns  
% dx: horizontal distance between two subplots (Default: 0.1)  
% dy: vertical distance between two subplots (Default: 0.1)  
% istest: draw the plot for check or not? (1: check, Default: 0)  
% x0: initial horizontal bias of the first subplot (Default: 0.05)  
% y0: initial vertical bias of the first subplot (Default: 0.08)  
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

## fun_errorbarchart
在科技文章，比較兩個樣本之間的差異是經常遇到的事情，我們可以使用Matlab的errorbar圖、bar圖和統計檢驗的方法去比較他們的差異，可惜的是，Matlab沒有一個可以同時把這些内容繪畫出來的函數；
因此，我編寫了一個這樣的函數`fun_errorbarchart()`去完成這個事情，

### How to use `fun_errorbarchart()`?  
```
function fun_errorbarchart(dat_x,dat_y1,dat_y2,test_pval0,title_str,x_lab_str,y_lab_str,legend_str1,legend_str2,star_ypos,plot_pos)  
% This function is used to compare two input data in the bar chart and  
% error-bar,the statistical test results are shown at the same time.  
%  
% dat_x: 1 x N  
% dat_y1: M x N  
% dat_y2: M x N  
% test_pval0:  
% 1) test_pval0: 1 x N (statistical test results between two samples: dat_y1 and dat_y2  
% 2) test_pval0: 1 (Calculate the paired t-test result (tail: both))  
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
![result3](https://github.com/edwin465/matlab-mytoolbox-plot/blob/main/subplot_plot.png)

