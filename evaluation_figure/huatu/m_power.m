clear;
data  = xlsread('power0728.xlsx', 'B2:L8');
power=zeros(7,1);
ber=zeros(7,1);
throughput2=zeros(7,1);
power(1:7,1)=data(1:7,2);

ber(1:7,1)=[1 1 1 1 1 1 1]'-data(1:7,10);
throughput2(1:7,1)=1e6/140*ber(1:7,1);
figure;bar(power,ber); xlabel('Power','FontSize',14);ylabel('BER','FontSize',14);ylim([0 0.2]);
figure;bar(power,throughput2); xlabel('Power','FontSize',14);ylabel('Throughput(theory)','FontSize',14);