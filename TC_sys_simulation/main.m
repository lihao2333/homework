clear all;close all;clc;
nx=-4:4;
x=[1 2 3 4 5 6 7 8 9]
L1=3;L2=4;L3=7;L4=9;L5=12;k=3;
[ny1,y1]=SeqZQYT(nx,x,L1,k);
[ny2,y2]=SeqZQYT(nx,x,L2,k);
[ny3,y3]=SeqZQYT(nx,x,L3,k);
[ny4,y4]=SeqZQYT(nx,x,L4,k);
[ny5,y5]=SeqZQYT(nx,x,L5,k);
subplot(321),
stem(nx,x,'.');grid;axis([-5 5 -1 10]);
xlabel('nx');ylabel('x(n)');title('原序列');
subplot(322),
stem(ny1,y1,'.');grid;axis([-5 8 -1 25]);
xlabel('ny1');ylabel('y1(n)');title('周期为3的周期序列');
subplot(323),
stem(ny2,y2,'.');grid;axis([-5 10 -1 20]);
xlabel('ny2');ylabel('y2(n)');title('周期为4的周期序列');
subplot(324),
stem(ny3,y3,'.');grid;axis([-5 18 -1 15]);
xlabel('ny3');ylabel('y3(n)');title('周期为7的周期序列');
subplot(325),
stem(ny4,y4,'.');grid;axis([-5 25 -1 15]);
xlabel('ny4');ylabel('y4(n)');title('周期为9的周期序列');
subplot(326),
stem(ny5,y5,'.');grid;axis([-5 32 -1 12]);
xlabel('ny5');ylabel('y5(n)');title('周期为12期序列');
