function [BLE_CSI_effect, BLE_frame_index, BLE_frame_num] = detect_BLE_frame(ComplxCSI, THRESHOLD)

SubIndex = [7:32 34:59];
BLE_frame_num = 0;

BLE_SubIndex = [21: 30];

AbsCSI = abs(ComplxCSI);

figure; plot(reshape(AbsCSI, 1, []));

frameNum = size(ComplxCSI,2);

SubDataAbsCSI = abs(ComplxCSI(SubIndex, :));
MeanCSI = mean(SubDataAbsCSI, 1);

BLE_CSI = zeros(64, frameNum);
BLE_CSI(BLE_SubIndex, :) = (abs(ComplxCSI(BLE_SubIndex, :)) - repmat(MeanCSI, length(BLE_SubIndex), 1));

% BLE_CSI_index = zeros(64, 1);

BLE_CSI_effect = zeros(64, frameNum);
for index = 1: frameNum
    BLE_CSI_index = find(abs(BLE_CSI(:, index)) >= THRESHOLD, 1);
    if isempty(BLE_CSI_index)
        continue;
    end
    BLE_frame_num = BLE_frame_num + 1;
    BLE_CSI_effect(BLE_SubIndex, BLE_frame_num) = BLE_CSI(BLE_SubIndex, index);
    BLE_frame_index(BLE_frame_num) = index;
end
BLE_CSI_effect = BLE_CSI_effect(:, 1: BLE_frame_num);







% figure; plot(abs(ComplxCSI));































