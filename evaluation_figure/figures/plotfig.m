clear; close all;
F1 = [-200 -150 -120 -100 -50 0 50 100 120 150 200];
PRR_WiFi = [0.6875 0.9998 0.9996 0.9979 0.9939 0.9980 0.9967 0.9907 0.9999 0.9998 0.6889];


rate = [352*4	420*4 696*2	758*2 1387	1539 403*4	623*4 831	2026 1589	1905 1024	386 1931 ...
        1643 1783	1999 1175	 1481	1694 1394	1868 1624	1626 1755	2028];


Mean_BLE = 500e3 * 2; 

F2 = [-200 -150 -140 -130 -120 -110 -100 -50 0 50 100 110 120 130 140 150 200];
PRR_BLE = [0.000 0.000 0.668 0.964 0.986 0.964 0.949 0.962 0.951 0.951 0.951 0.951 0.951 0.964 0.415 0.000 0.000];

Mean_WiFi = 720e3 * 20;
throughput_wifi = PRR_WiFi * Mean_WiFi;


throughput_BLE = PRR_BLE * Mean_BLE;
Freq = [0 50 100 150 200];
y1_cha = interp1(F1, throughput_wifi, Freq, 'linear');

y2_cha = interp1(F2, throughput_BLE, Freq,'linear');

E = repmat(std(rate)/5, 5, 1);
figure;
bar(Freq, ([y1_cha; y2_cha]./1e6).'); xlabel('Freq(KHz)','FontSize',20);ylabel('BER','FontSize',20);
hold on;
% set(gca,'yscale','log');
% errorbar(Freq-7, [y1_cha].',E, 'Marker','none','LineStyle','none')

xlabel('Frequency shift(kHz)','FontSize',20);
ylabel('Throughput(Mbps)','FontSize',20);
% ylim([1 1e4]);
h=legend('Wi-Fi','BLE');
% set(h,'Fontsize',14);

% figure;bar(freq_5,[y1_cha y2_cha]);
% set(gca,'yscale','log');
% xlabel('Frequency shift£¨kHz£©','FontSize',14);
% ylabel('BER','FontSize',14);
% h=legend('wifi','ble');
% set(h,'Fontsize',14);