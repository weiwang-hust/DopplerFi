clear;
data  = xlsread('ble0727.xlsx', 'A2:J11');
distance1=zeros(5,1);
ble_ber_los=zeros(5,1);
ble_throughput1_los=zeros(5,1);
ble_throughput2_los=zeros(5,1);
distance1(1:5,1)=data(1:5,3);
ble_ber_los(1:5,1)=[1 1 1 1 1]'-data(1:5,10);
ble_throughput1_los(1:5,1)=(410*data(1:5,8)+410*data(1:5,9))./(2^20*16)*4e7/2;
ble_throughput2_los(1:5,1)=1e6/625*data(1:5,10);

% [hAx,hLine1,hLine2]=plotyy(distance,warp_ber_los,distance,warp_throughput_los);
% set(hLine1,'Marker','*');
% set(hLine2,'Marker','^');
% ylabel(hAx(1),'BER');
% ylabel(hAx(2),'Throughput');
% xlabel('Distance(m)');
% title('BER and throughout of different distance');

distance2=zeros(5,1);
ble_ber_nlos=zeros(5,1);
ble_throughput1_nlos=zeros(5,1);
ble_throughput2_nlos=zeros(5,1);
distance2(1:5,1)=data(6:10,3);
ble_throughput1_nlos(1:5,1)=(383*data(6:10,8)+383*data(6:10,9))./(2^20*16)*4e7/2;
ble_throughput2_nlos(1:5,1)=1e6/625*data(6:10,10);
ble_ber_nlos(1:5,1)=[1 1 1 1 1]'-data(6:10,10);

% [hAx,hLine1,hLine2]=plotyy(distance,warp_ber,distance,warp_throughput);
% set(hLine1,'Marker','*');
% set(hLine2,'Marker','^');
% ylabel(hAx(1),'BER');
% ylabel(hAx(2),'Throughput');
% xlabel('Distance(m)');
% title('BER and throughout of different distance');
figure;
plot(distance1,ble_ber_los,'-*','linewidth',1.5);
hold on;plot(distance2,ble_ber_nlos,'-^','linewidth',1.5);
le1=legend('LOS','NLOS');
set(le1,'FontSize',14);
ylabel('BER','FontSize',14);
xlabel('Distance(m)','FontSize',14);

figure;
plot(distance1,ble_throughput1_los,'-*','linewidth',1.5);
hold on;plot(distance2,ble_throughput1_nlos,'-^','linewidth',1.5);
le2=legend('LOS','NLOS');
set(le2,'FontSize',14);
ylabel('Throughput(real)','FontSize',14);
xlabel('Distance(m)','FontSize',14);

figure;
plot(distance1,ble_throughput2_los,'-*','linewidth',1.5);
hold on;plot(distance2,ble_throughput2_nlos,'-^','linewidth',1.5);
le2=legend('LOS','NLOS');
set(le2,'FontSize',14);
ylabel('Throughput£¨maximum)','FontSize',14);
xlabel('Distance(m)','FontSize',14);
