clear; close all;

FILE_PATH = 'E:\Programs\MATLAB\Cross-technology Communication\CSI\File0720\';

FILE_TAIL = '_1m-1';
BLE_DISTRUB_THRESHOLD = 0.5;
SLICE_THRESHOLD = 26;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
ComplxCSI1 = read_WARP([FILE_PATH 'WARPLAB_CSI_OFFSET125k_m_1m-1' ]);
[BLE_CSI_effect1, BLE_CSI_index1, BLE_CSI_num1] = detect_BLE_frame(ComplxCSI1, BLE_DISTRUB_THRESHOLD);
[BLE_CSI_result1, max_CSI_index1, BLE_frame_num1] = BLE2WiFi_decode1(BLE_CSI_effect1, BLE_CSI_index1);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
ComplxCSI2 = read_WARP([FILE_PATH 'WARPLAB_CSI_OFFSET125k_1m-4' ]);
[BLE_CSI_effect2, BLE_CSI_index2, BLE_CSI_num2] = detect_BLE_frame(ComplxCSI2, BLE_DISTRUB_THRESHOLD);
[BLE_CSI_result2, max_CSI_index2, BLE_frame_num2] = BLE2WiFi_decode1(BLE_CSI_effect2, BLE_CSI_index2);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
CSI_threshold_index1 = find(max_CSI_index1 == SLICE_THRESHOLD);
CSI_threshold_index2 = find(max_CSI_index2 == SLICE_THRESHOLD);


% for index = 1: length(CSI_threshold_index1)
%     if abs(BLE_CSI_result1(SLICE_THRESHOLD-1, CSI_threshold_index1(index))) > abs(BLE_CSI_result1(SLICE_THRESHOLD+1, CSI_threshold_index1(index)))
%         max_CSI_index1(CSI_threshold_index1(index)) = max_CSI_index1(CSI_threshold_index1(index)) -1;
%     else
%         max_CSI_index1(CSI_threshold_index1(index)) = max_CSI_index1(CSI_threshold_index1(index)) +1;
%     end
% end
% 
% for index = 1: length(CSI_threshold_index2)
%     if abs(BLE_CSI_result2(SLICE_THRESHOLD-1, CSI_threshold_index2(index))) > abs(BLE_CSI_result2(SLICE_THRESHOLD+1, CSI_threshold_index2(index)))
%         max_CSI_index2(CSI_threshold_index1(index)) = max_CSI_index2(CSI_threshold_index2(index)) -1;
%     else
%         max_CSI_index2(CSI_threshold_index1(index)) = max_CSI_index2(CSI_threshold_index1(index)) +1;
%     end
% end

BLE_frame_num1
BLE_frame_num2
BRR1 = length(find(max_CSI_index1 <= SLICE_THRESHOLD)) / BLE_frame_num1
BRR2 = length(find(max_CSI_index2 >  SLICE_THRESHOLD)) / BLE_frame_num2
BER = (BRR1 * BLE_frame_num1 + BRR2 * BLE_frame_num2)/(BLE_frame_num1+BLE_frame_num2)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
for index = 1: 10
    % figure; stem(BLE_CSI_result1(:, CSI_threshold_index1(index))); title('<= threshold');
    % figure; stem(BLE_CSI_result2(:, CSI_threshold_index2(index))); title('>  threshold');
end
figure; hold on;
plot(max_CSI_index1, 'r');
plot(max_CSI_index2, 'b');



