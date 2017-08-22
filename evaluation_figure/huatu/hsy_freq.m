clear;
% data  = xlsread('ble0727_diff.xlsx', 'B2:J6');
% freq_5=zeros(5,1);
% ber=zeros(5,1);
% throughput1=zeros(5,1);
% throughput2=zeros(5,1);
% freq_5(1:5,1)=data(1:5,1);
% %-100 75; 125; -130 100; 140
data = [0.7875 0.8861 0.9002 0.9314];
ratei = 316.4050;
throughput1 = ratei * data;
% throughput2(1:5,1)=1e6/625*data(1:5,9);
ber=[1 1 1 1]-data;
figure;bar(ber); xlabel('Frequency shift(kHz)','FontSize',14);ylabel('BER','FontSize',14);ylim([0 0.3]);
figure;bar(throughput1);xlabel('Frequency shift(kHz)','FontSize',14);ylabel('Throughput','FontSize',14);ylim([0 500]);
% figure;bar(125-4*15.625:15.625:125,throughput2);xlabel('Frequency shift(kHz)','FontSize',14);ylabel('Throughput(maximum)','FontSize',14);ylim([0 2000]);