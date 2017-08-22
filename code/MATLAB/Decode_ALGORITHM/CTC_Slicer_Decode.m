clear; close all;

FILE_LEN = 4e6;
FILE_PATH = 'D:\Documents\MATLAB\WARP\WARP_File\WARPFile20170718_LoS\';
% FILE_PATH = 'C:\Users\He\Documents\MATLAB\WARP\WARP_File\WARPFile20170719\';
% FILE_PATH = 'C:\Users\He\Documents\MATLAB\WARP\WARP_File\WARPFile20170720_power\';

FILE_TYPE1 = 'warp';
% FILE_TYPE2 = 'recovery19';
% FILE_TYPE3 = 'binary';
FILE_TYPE3 = 'binary_slicer';
% 
% OFFSET1 = '_offset100m_1m_los';
% OFFSET2 = '_offset130_1m_los';

OFFSET1 = '_off125m_3m';
OFFSET2 = '_off125_3m';

RSSI_THRESHOLD = 4;
FRAME_BEGIN = -2;
FRAME_LENGTH_CONTINUE = 0;
FRAME_LENGTH = 16;
decide = 0;

%% read file offset0
fid = fopen([FILE_PATH  FILE_TYPE1  OFFSET1 ], 'r');
received_data = fread(fid, FILE_LEN, 'float');
fclose(fid);
received_data = reshape(received_data, 2, []).';
complex_data = received_data(:, 1) + 1j * received_data(:, 2);
% fid = fopen([FILE_PATH  FILE_TYPE2  OFFSET1 ], 'r');
% recovery_data = fread(fid, FILE_LEN/4, 'float');
% fclose(fid);
fid = fopen([FILE_PATH  FILE_TYPE3  OFFSET1 ], 'r');
slicer_data = fread(fid, FILE_LEN/4, 'char');
fclose(fid);
for index2 = 1: FILE_LEN/4
    if slicer_data(index2) > 1
        slicer_data(index2) = -1;
    end
end
fid = fopen([FILE_PATH  FILE_TYPE1  OFFSET2 ], 'r');
received_data_offset = fread(fid, FILE_LEN, 'float');
fclose(fid);
received_data_offset = reshape(received_data_offset, 2, []).';
complex_data_offset = received_data_offset(:, 1) + 1j * received_data_offset(:, 2);
% fid = fopen([FILE_PATH  FILE_TYPE2  OFFSET2 ], 'r');
% recovery_data_offset = fread(fid, FILE_LEN/4, 'float');
% fclose(fid);
fid = fopen([FILE_PATH  FILE_TYPE3  OFFSET2 ], 'r');
slicer_data_offset = fread(fid, FILE_LEN/4, 'char');
fclose(fid);
for index2 = 1: FILE_LEN/4
    if slicer_data_offset(index2) > 1
        slicer_data_offset(index2) = -1;
    end
end

figure; plot(real(complex_data), 'b'); hold on; plot(imag(complex_data), 'r');
figure; plot(real(complex_data_offset), 'b'); hold on; plot(imag(complex_data_offset), 'r');
% figure; stem(recovery_data);
% figure; stem(recovery_data_offset);
figure; stem(slicer_data);
figure; stem(slicer_data_offset);


%% slicer signal RSSI
%
[~, slicer_index, frame_num1] = RSSI_calculation(slicer_data, RSSI_THRESHOLD, FRAME_BEGIN, FRAME_LENGTH_CONTINUE, FRAME_LENGTH);

for index2 = 1: frame_num1
    loop_index1 = slicer_index(:, index2);
    % figure; stem( slicer_data(loop_index1) ); title('binary slicer'); ylim([-2 2]);
    slicer_sum(index2) = sum(slicer_data(loop_index1));
end

%

%% slicer signal(offset)
[~, slicer_index_offset, frame_num2] = RSSI_calculation(slicer_data_offset, RSSI_THRESHOLD, FRAME_BEGIN, FRAME_LENGTH_CONTINUE, FRAME_LENGTH);

for index2 = 1: frame_num2
    loop_index1 = slicer_index_offset(:, index2);
    % figure; stem( slicer_data_offset(loop_index1) ); title('binary slicer offset'); ylim([-2 2]);
    slicer_sum_offset(index2) = sum(slicer_data_offset(loop_index1));
end
frame_num1
frame_num2
figure; subplot(211); stem(slicer_sum); title('receiver offset -125'); subplot(212); stem(slicer_sum_offset); title('receiver offset 125');


BRR1 = sum(slicer_sum < decide) / frame_num1
BRR0 = sum(slicer_sum_offset >= decide) / frame_num2

%}
