function SubCentralFreq = WiFi_SubcarrierCentralFreq(CentralFreq)
% CentralFreq: vector
% SubCentralFreq: matrix

space = 0.3125;
SbuCentralFreq = zeros(64, length(CentralFreq));
for Index = 1: length(CentralFreq);
    SubCentralFreq(:, Index) = (CentralFreq(Index) - space * 32): space: (CentralFreq(Index) + space * 31);
end