clear; close all;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% n = 0: 1: 7;
% A1 = -1-j;
% A2 = 1+j;
% 
% delta = 0.125;
% 
% f1 = -0.5 + delta;
% f2 = 0.75 + delta;
% fs = 2;
% 
% if f1 < -1
%     f1 = 0;
% end
% 
% x = A1 * exp(j*2*pi*f1/fs*n) + A2 * exp(j*2*pi*f2/fs*n);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
FILE_BEGIN = 0;
FILE_LEN = 5e4;
% FILE_PATH = 'C:\Users\He\Documents\MATLAB\WARP\WARP_File\WARPFile20170722_eve\';
% FILE_PATH = 'F:\WiFiBLE\WARPFIle\WARPFile20170725\';
FILE_PATH = 'E:\Programs\MATLAB\Cross-technology Communication\WARPFile\WARPFile20170726\';

FILE_TYPE1 = 'warp';
FILE_TYPE3 = 'binary';

OFFSET1 = '_offset100m_1m_los-3';
OFFSET2 = '_offset130_1m_los-3';

RSSI_THRESHOLD = 0.02;
FRAME_BEGIN = 0;
FRAME_LENGTH_CONTINUE = 0;
FRAME_LENGTH = 32;
decide = 0;


%% read file offset0
fid = fopen([FILE_PATH  FILE_TYPE1  OFFSET1 ], 'r');
received_data1 = fread(fid, FILE_BEGIN + FILE_LEN, 'float');
fclose(fid);
received_data1 = reshape(received_data1, 2, []).';
complex_data1 = received_data1(:, 1) + 1j * received_data1(:, 2);
complex_data1 = complex_data1(FILE_BEGIN/2+1: FILE_BEGIN/2 + FILE_LEN/2);


fid = fopen([FILE_PATH  FILE_TYPE1  OFFSET2 ], 'r');
received_data2 = fread(fid, FILE_BEGIN + FILE_LEN, 'float');
fclose(fid);
received_data2 = reshape(received_data2, 2, []).';
complex_data2 = received_data2(:, 1) + 1j * received_data2(:, 2);

complex_data2 = complex_data2(FILE_BEGIN/2+1: FILE_BEGIN/2 + FILE_LEN/2);

% figure; plot(real(complex_data1), 'b'); hold on; plot(imag(complex_data1), 'r');
% figure; plot(real(complex_data2), 'b'); hold on; plot(imag(complex_data2), 'r');

[complex_data1, received_index1, frame_num1] = RSSI_calculation1(complex_data1, RSSI_THRESHOLD, FRAME_BEGIN, FRAME_LENGTH_CONTINUE, FRAME_LENGTH);
[complex_data2, received_index2, frame_num2] = RSSI_calculation1(complex_data2, RSSI_THRESHOLD, FRAME_BEGIN, FRAME_LENGTH_CONTINUE, FRAME_LENGTH);
% figure; plot(real(complex_data1), 'b'); hold on; plot(imag(complex_data1), 'r');
% figure; plot(real(complex_data2), 'b'); hold on; plot(imag(complex_data2), 'r');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% corr_result = zeros(size(complex_data1));
% for index = 1: length(complex_data1) - length(x)
%     corr_result(index) = x * complex_data1(index: index + length(x)-1);
% end
% figure; plot(abs(corr_result));
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

quarture1 = angle([complex_data1; 0] .* [0; conj(complex_data1)]);
quarture2 = angle([complex_data2; 0] .* [0; conj(complex_data2)]);

slicer1 = zeros(size(quarture1));
for index = 2: length(quarture1)
    if abs(complex_data1(index-1)) > 0
        if quarture1(index) > 0
            slicer1(index) = 1;
        else
            slicer1(index) = -1;
        end
    end
end

slicer2 = zeros(size(quarture2));
for index = 2: length(quarture2)
    if abs(complex_data2(index-1)) ~= 0
        if quarture2(index) > 0
            slicer2(index) = 1;
        else
            slicer2(index) = -1;
        end
    else
        slicer2(index) = 0;
    end
end


frame_num1 = 0;
for index = 1: 10
    complex_data1(index) = 0;
    complex_data2(index) = 0;
end

for index = 2: length(complex_data1)
    if abs(complex_data1(index)) ~= 0 && abs(complex_data1(index-1)) == 0
        received_data_pattern1(:, index) = complex_data1(index+FRAME_BEGIN+1: index+FRAME_BEGIN+FRAME_LENGTH);
%         figure; plot(abs(fft(received_data_pattern1(:, index))));
%         figure; plot(real(received_data_pattern1(:, index)), 'b'); hold on;
%             plot(imag(received_data_pattern1(:, index)), 'r'); hold on;
%         figure; stem(quarture1(index+FRAME_BEGIN+1: index+FRAME_BEGIN+FRAME_LENGTH));
%         figure; stem(slicer1(index+FRAME_BEGIN+1: index+FRAME_BEGIN+FRAME_LENGTH));
        frame_num1 = frame_num1 + 1;
        received_begin1(frame_num1) = index;
        pattern1(:, index) = slicer1(index+FRAME_BEGIN+1:2: index+FRAME_BEGIN+FRAME_LENGTH).';
        pattern_sum1(frame_num1) = abs(sum(pattern1(:, index) - pattern1(:, 1))/2);
        slicer_sum1(frame_num1) = sum(pattern1(:, index));
    end
end

% figure; stem(slicer1(index+FRAME_BEGIN+1: index+FRAME_BEGIN+FRAME_LENGTH));

frame_num2 = 0;
for index = 2: length(complex_data2)
    if (abs(complex_data2(index)) ~= 0) && (abs(complex_data2(index-1)) == 0)
        received_data_pattern2(:, index) = complex_data2(index+FRAME_BEGIN+1: index+FRAME_BEGIN+FRAME_LENGTH);
%         figure; plot(abs(fft(received_data_pattern2(:, index))));
% %         figure; plot(angle(fft(received_data_pattern2(:, index))));
%         figure; plot(real(received_data_pattern2(:, index)), 'b'); hold on;
%             plot(imag(received_data_pattern2(:, index)), 'r'); hold on;
%         figure; stem(quarture2(index+FRAME_BEGIN+1: index+FRAME_BEGIN+FRAME_LENGTH));
        frame_num2 = frame_num2 + 1;
        received_begin2(frame_num2) = index;
        pattern2(:, index) = slicer2( index+FRAME_BEGIN+1:2: index+FRAME_BEGIN+FRAME_LENGTH).';
%         figure; stem(slicer2(index+FRAME_BEGIN+1: index+FRAME_BEGIN+FRAME_LENGTH));
%         pattern_sum2(frame_num2) = abs(sum(pattern2(:, index) - pattern1(:, 1))/2);
        slicer_sum2(frame_num2) = sum(pattern2(:, index));
    end
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
index1 = received_begin1(26);
index2 = received_begin2(34);

figure; plot(real(received_data_pattern1(:, index1)), 'b'); hold on;
        plot(imag(received_data_pattern1(:, index1)), 'r'); hold on;
        
figure; plot(2410 + (-1: 2/32: 1-1/16), abs(fft(received_data_pattern1(:, index1)))); hold on; 
        plot(2410 + (-1: 2/32: 1-1/16), abs(fft(received_data_pattern2(:, index2))));
        
figure; plot(real(received_data_pattern2(:, index2)), 'b'); hold on;
        plot(imag(received_data_pattern2(:, index2)), 'r'); hold on;
        
figure; stem(quarture1(index1+FRAME_BEGIN+1: index1+FRAME_BEGIN+FRAME_LENGTH));       
figure; stem(quarture2(index2+FRAME_BEGIN+1: index2+FRAME_BEGIN+FRAME_LENGTH));

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% figure; plot(real(complex_data1), 'b'); hold on; plot(imag(complex_data1), 'r');
% figure; plot(real(complex_data2), 'b'); hold on; plot(imag(complex_data2), 'r');

myindex = 9;
% figure; plot(real(complex_data1(received_begin1(myindex)+1: received_begin1(myindex)+FRAME_LENGTH)), 'b'); hold on; 
%         plot(imag(complex_data1(received_begin1(myindex)+1: received_begin1(myindex)+FRAME_LENGTH)), 'r');
% figure; plot(real(complex_data2(received_begin2(myindex)+1: received_begin2(myindex)+FRAME_LENGTH)), 'b'); hold on; 
%         plot(imag(complex_data2(received_begin2(myindex)+1: received_begin2(myindex)+FRAME_LENGTH)), 'r');
% figure; stem(slicer1(received_begin1(myindex)+1: received_begin1(myindex)+FRAME_LENGTH));
% figure; stem(slicer2(received_begin2(myindex)+1: received_begin2(myindex)+FRAME_LENGTH));

% figure; stem(quarture1);
% figure; stem(quarture2);

% figure; stem(slicer1);
% figure; stem(slicer2);

% figure; stem(pattern_sum1); hold on; stem(pattern_sum2)
figure; subplot(211); stem(slicer_sum1);subplot(212); stem(slicer_sum2);
% received_begin1
% received_begin2
frame_num1
frame_num2
BRR1 = sum(slicer_sum1 <= 0) / frame_num1
BRR0 = sum(slicer_sum2 >  0) / frame_num2