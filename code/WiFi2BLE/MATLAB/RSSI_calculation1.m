function [complex_data, received_index, frame_num] = RSSI_calculation1(complex_data, rssi_threshold, frame_begin, frame_len_more, frame_len)
%input vector scalar
%output vector scalar


RSSI_LEN = 8;
MAX_FRAME_NUM = 20;
FILE_LEN = size(complex_data, 1);

index = RSSI_LEN;
frame_num = 0;
% received_index = zeros(frame_len, MAX_FRAME_NUM);
while(index < FILE_LEN - frame_len)
    RSSI_received(index) = complex_data(index - RSSI_LEN +1: index)' * complex_data(index - RSSI_LEN +1: index);
    if RSSI_received(index) >= rssi_threshold && RSSI_received(index -1) < rssi_threshold
        received_index(:, frame_num+1)= index - RSSI_LEN + frame_begin +1: index - RSSI_LEN  + frame_begin + frame_len;
        frame_num = frame_num + 1;
        index = index + 1;
        continue;
    end
    if RSSI_received(index) >= rssi_threshold
        complex_data(index) = complex_data(index);
    else
        complex_data(index) = 0;
    end
    index = index + 1;
end
% figure; plot(RSSI_received); ylim([-0.1, 10]);