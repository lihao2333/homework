**cosine**
----------
在cosine文件夹中，参考的matlab历程

**SERvsBER**
---------
在PracticeBER中  
基于老师的代码修改了`main_awgn`文件  
* 在每一个frame中，针对每个symbol进行判断，计算ser
* 把SNR从bit改为symbol

由于是linux系统，所以用qit绘图，结果如下:  
![img](graph2/ser-snr(bit).jpeg)  
![img](graph2/ser-snr(symbol).jpeg)  

如果是bit的SNR,对于y==0.1,QPSK和16QAM相差大约8dB，与书上差不多一致  
如果是symbol的SNR,和书上不一样.  
因为SNR(symbol)=10lg(log2(M))+SNR(bit)dB
所以QPSK会偏移3(12->15),16QAM会偏移6(18->24)  `零点偏移`


