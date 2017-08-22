clear; close all;

FILE_LEN = 4e6;
FILE_PATH = 'C:\Users\He\Documents\MATLAB\WARP\WARP_File\WARPFile20170721_los\';
DATE = '';
CARRIER_FREQ = '';
OFFSET1 = '_offset125m';
OFFSET2 = '_offset125';
RANGE = '_1m_los';

RSSI_THRESHOLD = 100;
FRAME_BEGIN = 0;
FRAME_LENGTH_CONTINUE = 0;
FRAME_LENGTH = 200;

%% read file offset-140
%
fid = fopen([FILE_PATH 'warp_offset125m' RANGE], 'r');
received_data = fread(fid, FILE_LEN, 'float');
fclose(fid);
received_data = reshape(received_data, 2, []).';
complex_data = received_data(:, 1) + 1j * received_data(:, 2);


figure; plot(real(complex_data), 'b'); hold on; plot(imag(complex_data), 'r');


%% received signal RSSI
%
[received_index, frame_num1] = RSSI_calculation(complex_data, RSSI_THRESHOLD, FRAME_BEGIN, FRAME_LENGTH_CONTINUE, FRAME_LENGTH);
for index2 = 1: frame_num1
    loop_index1 = received_index(:, index2);
    recovery_loop_index = floor(loop_index1(1: 2: end)/2);
    
    % figure; plot(real(complex_data( loop_index1 )), 'b'); hold on; 
    %         plot(imag(complex_data( loop_index1 )), 'r');
    % figure; plot(abs(fftshift(fft(complex_data( loop_index1 )))), 'b')
    % figure; plot(real(fftshift(fft(complex_data( loop_index1 )))), 'b'); hold on; 
    %         plot(imag(fftshift(fft(complex_data( loop_index1 )))), 'r');
    % figure; stem( quadrature_data(loop_index1) ); title('quadrature data');
    
end
%}

%% read file offset140
%
fid = fopen([FILE_PATH DATE 'warp' CARRIER_FREQ OFFSET2 RANGE], 'r');
received_data_offset = fread(fid, FILE_LEN, 'float');
fclose(fid);
received_data_offset = reshape(received_data_offset, 2, []).';
complex_data_offset = received_data_offset(:, 1) + 1j * received_data_offset(:, 2);


figure; plot(real(complex_data_offset), 'b'); hold on; plot(imag(complex_data_offset), 'r');


%% received signal(offset)
%
[received_index_offset, frame_num2] = RSSI_calculation(complex_data_offset, RSSI_THRESHOLD, FRAME_BEGIN, FRAME_LENGTH_CONTINUE, FRAME_LENGTH);

for index2 = 1: frame_num2
    loop_index1 = received_index_offset(:, index2);
    recovery_offset_loop_index = floor(loop_index1(1: 2: end)/2);
    % figure; plot(real(complex_data_offset( loop_index1 )), 'b'); hold on; 
    %         plot(imag(complex_data_offset( loop_index1 )), 'r');
    % figure; plot(abs(fftshift(fft(complex_data_offset( loop_index1 )))), 'b')
    % figure; plot(real(fftshift(fft(complex_data_offset( loop_index1 )))), 'b'); hold on; 
    %         plot(imag(fftshift(fft(complex_data_offset( loop_index1 )))), 'r');
    % figure; stem( quadrature_data_offset(loop_index1) ); title('quadrature data offset');
    
end

%}
