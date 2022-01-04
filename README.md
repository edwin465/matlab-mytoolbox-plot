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

