clear;
data  = xlsread('CTC.xlsx', 'A2:J76');
sum1=0;
sum2=0;
k1=0;
k2=0;
los_throughput=zeros(5,1);
los_ber=zeros(5,1);
for i=1:25
    sum1=sum1+data(i,6);
    sum2=sum2+data(i,7);
    k1=k1+data(i,6)*data(i,8);
    k2=k2+data(i,7)*data(i,9);
    if(mod(i,5)==0)
        los_throughput(i/5,1)=(k1+k2)/(2*2^20*40)*4e7;
        k1=k1/sum1;
        k2=k2/sum2;
        los_ber(i/5,1)=1-(k1*sum1+k2*sum2)/(sum1+sum2);
        k1=0; k2=0;       
        sum1=0;sum2=0;
    end
end  
% sum1=0;
% sum2=0;
% k1=0;
% k2=0;
% nlos_ber=zeros(5,1);
% nlos_throughput=zeros(5,1);
% for i=26:50
%     sum1=sum1+data(i,6);
%     sum2=sum2+data(i,7);
%     k1=k1+data(i,6)*data(i,8);
%     k2=k2+data(i,7)*data(i,9);
%     if(mod(i,5)==0)
%         nlos_throughput(i/5-5,1)=(k1+k2)/(2*2^20*40)*4e7;
%         k1=k1/sum1;
%         k2=k2/sum2;
%         nlos_ber(i/5-5,1)=1-(k1*sum1+k2*sum2)/(sum1+sum2);
%         k1=0; k2=0;       
%         sum1=0;sum2=0;
%     end
% end
% sum1=0;
% sum2=0;
% k1=0;
% k2=0;
% freq_ber=zeros(3,1);
% freq_throughput=zeros(3,1);
% for i=51:60
%     sum1=sum1+data(i,6);
%     sum2=sum2+data(i,7);
%     k1=k1+data(i,6)*data(i,8);
%     k2=k2+data(i,7)*data(i,9);
%     if(mod(i,5)==0)
%         freq_throughput(i/5-10,1)=(k1+k2)/(2*2^20*40)*4e7;
%         k1=k1/sum1;
%         k2=k2/sum2;
%         freq_ber(i/5-10,1)=1-(k1*sum1+k2*sum2)/(sum1+sum2);
%         k1=0; k2=0;       
%         sum1=0;sum2=0;
%     end
% end

sum1=0;
sum2=0;
k1=0;
k2=0;
channel_ber=zeros(4,1);
channel_throughput1=zeros(4,1);
channe2_throughput1=zeros(4,1);
for i=61:75
    sum1=sum1+data(i,6);
    sum2=sum2+data(i,7);
    k1=k1+data(i,6)*data(i,8);
    k2=k2+data(i,7)*data(i,9);
    if(mod(i,5)==0)
        channel_throughput1(i/5-12,1)=(k1+k2)/(2*2^20*40)*4e7;
        k1=k1/sum1;
        k2=k2/sum2;
        channel_ber(i/5-12,1)=1-(k1*sum1+k2*sum2)/(sum1+sum2);
        k1=0; k2=0;       
        sum1=0;sum2=0;
    end
end
x2=[6 8 10 12];
channel_ber(4,1)=channel_ber(3,1);
channel_ber(3,1)=los_ber(1,1);
channel_throughput1(4,1)=205*(data(75,8)+data(75,9)+data(74,8)+data(74,9)+data(73,8)+data(73,9)+data(72,8)+data(72,9)+data(71,8)+data(71,9))/(2*2^20*40)*4e7;
channel_throughput2(1:4,1)=(1e6/625)*([1 1 1 1]'-channel_ber(1:4,1));
channel_throughput1(3,1)=los_throughput(1,1);
figure;bar(x2,channel_ber); xlabel('channel','FontSize',14);ylabel('BER','FontSize',14);ylim([0 0.08]);
figure;bar(x2,channel_throughput1);xlabel('channel','FontSize',14);ylabel('Throughput(real)','FontSize',14);ylim([0 1300]);
figure;bar(x2,channel_throughput2);xlabel('channel','FontSize',14);ylabel('Throughput(maximum)','FontSize',14);ylim([1200 1700]);
% x1=[62.5 93 125];
% freq_throughput(3,1)=los_throughput(1,1);
% freq_ber(3,1)=los_ber(1,1);
% % figure;bar(x1,[freq_throughput freq_ber]);
% figure;bar(x1,freq_ber); xlabel('freq(Hz)');ylabel('BER');title('BER of different frequence');ylim([0 0.09]);
% figure;bar(x1,freq_throughput);xlabel('freq(Hz)');ylabel('Throughput');title('Throughput of different frequence');ylim([0 1300]);
% 
% figure;plot(los_ber,'-*');
% hold on;
% plot(nlos_ber,'-^');
% xlabel('Distance(m)');
% ylabel('BER');
% title('BER of LOS and NLOS');
% legend('LOS BER','NLOS BER')
% 
% figure;plot(los_throughput,'-*');
% hold on;
% plot(nlos_throughput,'-^');
% xlabel('Distance(m)');
% ylabel('Throughput');
% title('Throughput of los and nlos');
% legend('LOS BER','NLOS BER');