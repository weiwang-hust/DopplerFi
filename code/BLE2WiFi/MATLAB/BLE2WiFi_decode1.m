function [BLE_CSI_result, max_CSI_index, BLE_frame_num] = BLE2WiFi_decode1(BLE_CSI_effect, BLE_CSI_index)

[~, max_CSI_effect_index] = max(abs(BLE_CSI_effect));

BLE_frame_num = 1;
BLE_CSI_result = zeros(size(BLE_CSI_effect));
max_CSI_index = zeros(1, size(BLE_CSI_effect, 2));
second_max_CSI_index = zeros(1, size(BLE_CSI_effect, 2));

CSI_BLE_ratio = zeros(1, size(BLE_CSI_effect, 2));

% find the maximum
for index = 1: size(BLE_CSI_effect, 2) - 1
    if BLE_CSI_index(index+1) - BLE_CSI_index(index) > 2
        BLE_frame_num = BLE_frame_num + 1;
    end
    CSI_BLE_ratio(BLE_frame_num) = CSI_BLE_ratio(BLE_frame_num) + 1;
    BLE_CSI_result(:, BLE_frame_num) = BLE_CSI_result(:, BLE_frame_num) + BLE_CSI_effect(:, index);
    max_CSI_index(BLE_frame_num) = max_CSI_index(BLE_frame_num) + max_CSI_effect_index(:, index);
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
BLE_CSI_result = BLE_CSI_result(:, 1: BLE_frame_num);
max_CSI_index = max_CSI_index(:, 1: BLE_frame_num);
CSI_BLE_ratio = CSI_BLE_ratio(:, 1: BLE_frame_num);
max_CSI_index = max_CSI_index ./ CSI_BLE_ratio;
