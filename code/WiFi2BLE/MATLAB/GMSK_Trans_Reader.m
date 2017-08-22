clear; close all;

FILE_LEN = 1e4;
FILE_PATH = 'E:\Programs\MATLAB\Cross-technology Communication\WARPFile\GMFSK\';

FILE_NAME = 'ubertooth_adv';


%% read file
fid = fopen([FILE_PATH FILE_NAME], 'r');
received_data = fread(fid, FILE_LEN, 'float');
fclose(fid);
received_data = reshape(received_data, 2, []).';
complex_data = received_data(:, 1) + 1j * received_data(:, 2);
mydata = complex_data(702: 1366);


figure; plot(real(complex_data), 'b'); hold on; plot(imag(complex_data), 'r');
% figure; plot(real(mydata), 'b'); hold on; plot(imag(mydata), 'r');
% figure; plot(angle([0; complex_data] .* [complex_data; 0]));

% figure; plot(abs(fft(mydata)), 'b'); 