
%% example of AWGN

clear
clc
tic
%%% ---------- simulation parameter ---------------------------
static_ser={};
SNR_Arr= [0:2:30];
static_ser=[static_ser,SNR_Arr];
for mdlevel=[4 16 ]
	% global initialization
	% 每个snr尝试1500次,每次发送100bit
	modLevel=mdlevel;% 调制阶数
	num_bit=100;      %% bit数
	
	SNR_Arr
	numSNR=length(SNR_Arr);
	numFrame_Arr= ones(1,numSNR)*1500; % 每个snr有1500frame
	TsigPower=1;% 信号功率为1
	
	for ns=1:numSNR %SNR circulation
	    %% -------------------------------------
		%% Per SNR initialization
	    SNR=SNR_Arr(ns);
	    numFrame=numFrame_Arr(ns);   
	    
	    SNR_linear=10^(SNR/10);% dB值换为线性值
	    NoisePower = sqrt(mdlevel)*TsigPower/SNR_linear;%计算噪声功率
	    NoiseAmp=sqrt(NoisePower/2);%
	      
	    %%-------initialization----------
	    num_total_error=0;
		num_total_error_symbol=0;
	    
	    for nf=1:numFrame %Frame circulation
	        %% ----------------发送端--------------------
	        %---------随机产生数据---------------------------
	        seriBit =randi([0 1],1,num_bit);
	        %%-------- QPSK 调制 -----------------------------
	        DataModed=modulation(seriBit,modLevel);       
			num_symbol=length(DataModed);
	        
	        %% ******************** 信道 *********************************************      
	        % -----add gaussian noise-----------------
	        Rdata=add_noise(DataModed,NoiseAmp);
	        
	        %% ******************** 接收端 *********************************************     
	        % ------------QPSK demodulation---------------------
	        BitDemoded=demodulation(Rdata,modLevel);
	        
	        % ------- calculate BER --------------------
	        num_error_bit=sum(abs(seriBit-BitDemoded));
	        num_total_error=num_total_error+num_error_bit;
			row_bitstream = reshape(seriBit,num_bit/num_symbol,num_symbol);%将原来的bitstream拆分成symbol
			ok_bitstream = reshape(BitDemoded,num_bit/num_symbol,num_symbol);%将解调后的bitstream拆分成symbol
			num_error_symbol=sum(~all(row_bitstream==ok_bitstream));%统计本frame的误符号率
			num_total_error_symbol=num_total_error_symbol+num_error_symbol;%累加到本snr的误符号率
	        
	    end   %% end for nf  frame
	    BER(ns) = num_total_error/(num_bit*nf);
		SER(ns) = num_total_error_symbol/(num_symbol*nf);
	    
	end  %% end for ns  snr
	SER;
	BER;
	static_ser=[static_ser,SER];
	if mdlevel==4
			color = 'r-';
	else
			color = 'g-';
	end
	static_ser
	semilogy(SNR_Arr,SER,color);
	axis([0 30 0 1])
	hold on
	grid on
end
write_ser=cat(1,static_ser{:})'
dlmwrite('data.txt',write_ser);
title('SERvsSNR')
xlabel('SNR(dB)')
ylabel('SER')
text(5,0.1,'QPSK')
text(13,0.1,'16QAM')
hold off
