x=[-200 -150 -120 -100 -50 0 50 100 120 150 200];
y1=[0.6875 0.9998 0.9996 0.9979 0.9939 0.9980 0.9967 0.9907 0.9999 0.9998 0.6889];

x2=[-200 -150 -140 -130 -120 -110 -100 -50 0 50 100 110 120 130 140 150 200];
y2=[0.000 0.000 0.668 0.964 0.986 0.964 0.949 0.962 0.951 0.951 0.951 0.951 0.951 0.964 0.415 0.000 0.000];
plot(x,y1,'--*k');
hold on ;
plot(x2,y2,'-or');
hold on ;

% scatter(x,y1,60,'kx');
% hold on
% scatter(x2,y2,60,'o');
% hold on

xlabel('ÆµÆ«£¨KHz£©');
ylabel('PRR');
set(get(gca,'YLabel'),'FontSize',20);

set(get(gca,'XLabel'),'FontSize',20);

set(gca,'fontsize',20);


h=legend('Wi-Fi','ble');
set(h,'Fontsize',20);
