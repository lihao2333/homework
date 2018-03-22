
%% example of AWGN

clear
clc
tic
%%% ---------- simulation parameter ---------------------------
for mdlevel=[4 16]
	% global initialization
	% 每个snr尝试1500次,每次发送100bit
	modLevel=mdlevel;% 调制阶数
	num_bit=100;      %% bit数
	
	SNR_Arr= [0:2:20];
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
	    NoisePower = TsigPower/SNR_linear;%计算噪声功率
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
	        
	        %% ******************** 信道 *********************************************      
	        % -----add gaussian noise-----------------
	        Rdata=add_noise(DataModed,NoiseAmp);
	        
	        %% ******************** 接收端 *********************************************     
	        % ------------QPSK demodulation---------------------
	        BitDemoded=demodulation(Rdata,modLevel);
	        
	        % ------- calculate BER --------------------
	        num_error_bit=sum(abs(seriBit-BitDemoded));
	        num_total_error=num_total_error+num_error_bit;
			num_error_symbol=~all(seriBit==BitDemoded);
			num_total_error_symbol=num_total_error_symbol+num_error_symbol;
	        
	    end   %% end for nf  frame
	    BER(ns) = num_total_error/(num_bit*nf);
		SER(ns) = num_total_error_symbol/(nf);
	    
	end  %% end for ns  snr
	SER
	BER
	if mdlevel==4
			color = 'r-';
	else
			color = 'g-';
	end
	semilogy(SNR_Arr,SER,color);
	axis([0 20 0 1])
	hold on
	grid on
end
title('SERvsSNR')
xlabel('SNR(dB)')
ylabel('SER')
text(5,0.1,'QPSK')
text(13,0.1,'16QAM')
hold off
