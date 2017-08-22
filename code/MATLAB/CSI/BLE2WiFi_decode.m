function [BLE_CSI_result, max_CSI_index, BLE_frame_num] = BLE2WiFi_decode(BLE_CSI_effect, BLE_CSI_index)


BLE_frame_num = 1;
BLE_CSI_result = zeros(size(BLE_CSI_effect));

for index = 1: size(BLE_CSI_effect, 2) - 1
    if BLE_CSI_index(index+1) - BLE_CSI_index(index) > 2
        BLE_frame_num = BLE_frame_num + 1;
    end
    BLE_CSI_result(:, BLE_frame_num) = BLE_CSI_result(:, BLE_frame_num) + BLE_CSI_effect(:, index);
end

BLE_CSI_result = BLE_CSI_result(:, 1: BLE_frame_num);
[~, max_CSI_index] = max(abs(BLE_CSI_result));