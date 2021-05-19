# matlab-mytoolbox-plot
基於matlab畫圖函數的二次開發，便於展示一些計算結果...

## fun_subplot_position
使用Matlab自帶的subplot()，不同subplot之間的默認距離有時候會覺得太大，使得繪圖内容顯得有點小，不利於觀看結果;
使用這個fun_subplot_position函數，可以設置subplot之間的距離，然後自動計算subplot函數的position vector，使不同subplot之間的結果集中一些。

## fun_errorbarchart
在科技文章，比較兩個樣本之間的差異是經常遇到的事情，我們可以使用Matlab的errorbar圖、bar圖和統計檢驗的方法去比較他們的差異，可惜的是，Matlab沒有一個可以同時把這些内容繪畫出來的函數；
因此，我編寫了一個這樣的函數fun_errorbarchart()去完成這個事情，
