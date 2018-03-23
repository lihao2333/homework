function [ny,y]=SeqZQYT(nx,x,L,k)
N=length(nx);
ny=min(nx):k*L+min(nx)-1;
y=zeros(1,k*L);
for i=0:k*L-1
		if L==N
				y(i+1)=x(mod(i,L)+1);
		end
		if L>N
				x1=[x zeros(1,L-N)];
				y(i+1)=x1(mod(i,L)+1);
		end
		if(L<N)&(L>N/2)
				x2=[x(1:N-L)+x(L+1:N) x(N-L+1:L)];
				y(i+1)=x2(mod(i,L)+1);
		end
		if L<=N/2
				if mod(N,2)==1
						xb=[x zeros(1,fix(N/2)-1)];
				else
						xb=[x zeros(1, N/2)];
				end
				x3=xb(1:L);
				if mod(N,L)==0
						for t=1:N/L-1
								x3=x3+xb(1+t*L:(t+1)*L);
						end
				else
						for t=1:fix(N/L)
								x3=x3+xb(1+t*L:(t+1)*L);
						end 
				end
				y(i+1)=x3(mod(i,L)+1);
		end
end
