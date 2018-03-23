subplot(2,2,1)
x = randn(1,100);hist(x,20);
ylabel('N_i');xlabel('(a)');
subplot(2,2,2)
x = randn(1,100);hist(x,5);
ylabel('N_i');xlabel('(b)');
subplot(2,2,3)
x = randn(1,1000);hist(x,50);
ylabel('N_i');xlabel('(c)');
subplot(2,2,4)
x = randn(1,100000);hist(x,50);
ylabel('N_i');xlabel('(d)');
