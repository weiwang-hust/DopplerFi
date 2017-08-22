clear; close all;
ShortPreamble = [0, 0, 0, 0, 0, 0, 0, 0, 1+1j, 0, 0, 0, -1-1j, 0, 0, 0, 1+1j, 0, 0, 0, -1-1j, 0, 0, 0, -1-1j, 0, 0, 0, 1+1j, 0, 0, 0, 0, ...
                 0, 0, 0, -1-1j, 0, 0, 0, -1-1j, 0, 0, 0, 1+1j, 0, 0, 0, 1+1j, 0, 0, 0, 1+1j, 0, 0, 0, 1+1j, 0, 0, 0, 0, 0, 0, 0];
ShortPreambleIndex_nozero = find(ShortPreamble);
ShortPreambleIndex_zero = find(ShortPreamble == 0);
WiFi_CentralFreq = [2412: 5: 2472, 2484];
WiFi_SubCentralFreq = WiFi_SubcarrierCentralFreq(WiFi_CentralFreq);
BLE_CentralFreq = 2402: 2: 2480;

y = sin(pi * (0: 1/63: 1)).';

figure; 
stem(WiFi_CentralFreq, 1.2 * ones(1, length(WiFi_CentralFreq))); hold on;
stem(BLE_CentralFreq, 1.5 * ones(1, length(BLE_CentralFreq))); hold on;
stem(WiFi_SubCentralFreq, repmat(y, 1, size(WiFi_SubCentralFreq, 2))); hold on;

ylim([0, 2]);
legend('WiFi central freq', 'BLE central freq', 'WiFi subcarriers');

figure; 
stem(BLE_CentralFreq, 1.5 * ones(1, length(BLE_CentralFreq)), 'r', '-'); hold on;
stem(WiFi_SubCentralFreq(ShortPreambleIndex_zero, 1), y(ShortPreambleIndex_zero), 'g', '--'); hold on;
stem(WiFi_SubCentralFreq(ShortPreambleIndex_nozero, 1), y(ShortPreambleIndex_nozero), 'b', '-'); hold on;

ylim([0, 2]);
legend('BLE central freq', 'WiFi channel 1 subcarriers', 'WiFi channel 1 STF subcarrier');