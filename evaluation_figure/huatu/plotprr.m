clear;
x=[-200 -150 -120 -100 -50 0 50 100 120 150 200];
y1=[0.6875 0.9998 0.9996 0.9979 0.9939 0.9980 0.9967 0.9907 0.9999 0.9998 0.6889];
y1_ber=-y1.^(1/1600)+1;


x2=[-200 -150 -140 -130 -120 -110 -100 -50 0 50 100 110 120 130 140 150 200];
y2=[0.000 0.000 0.668 0.964 0.986 0.964 0.949 0.962 0.951 0.951 0.951 0.951 0.951 0.964 0.415 0.000 0.000];
y2_ber=-y2.^(1/1600)+1;


data  = xlsread('ble0727_diff.xlsx', 'B2:J6');
freq_5=zeros(5,1);
ber=zeros(5,1);
freq_5(1:5,1)=data(1:5,1);
ber(1:5,1)=[1 1 1 1 1]'-data(1:5,9);


y1_cha=interp1(x,y1_ber,freq_5,'linear');

y2_cha=interp1(x2,y2_ber,freq_5,'linear');

figure;
bar(freq_5,ber); xlabel('Freq(KHz)','FontSize',14);ylabel('BER','FontSize',14);
set(gca,'yscale','log');
hold on;
semilogy(freq_5,10.^log10(y2_cha),'-or','linewidth',1.5);
 

xlabel('Frequency shift£¨kHz£©','FontSize',14);
ylabel('BER','FontSize',14);

h=legend('ble','ble');
set(h,'Fontsize',14);

figure;bar(freq_5,[y1_cha y2_cha]);
set(gca,'yscale','log');
xlabel('Frequency shift£¨kHz£©','FontSize',14);
ylabel('BER','FontSize',14);
h=legend('wifi','ble');
set(h,'Fontsize',14);
