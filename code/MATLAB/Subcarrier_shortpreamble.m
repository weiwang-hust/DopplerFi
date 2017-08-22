clear; close all;

ShortPreamble = [0, 0, 0, 0, 0, 0, 0, 0, 1+1j, 0, 0, 0, -1-1j, 0, 0, 0, 1+1j, 0, 0, 0, -1-1j, 0, 0, 0, -1-1j, 0, 0, 0, 1+1j, 0, 0, 0, 0, ...
                 0, 0, 0, -1-1j, 0, 0, 0, -1-1j, 0, 0, 0, 1+1j, 0, 0, 0, 1+1j, 0, 0, 0, 1+1j, 0, 0, 0, 1+1j, 0, 0, 0, 0, 0, 0, 0];
             
ChannelSpacing = 312.5;
carrier = 2412e3;
ShortPreambleIndex(33) = carrier;
ShortPreambleIndex(1:32) = carrier - 32 * ChannelSpacing: ChannelSpacing: carrier - ChannelSpacing;
ShortPreambleIndex(34: 64) = carrier + ChannelSpacing: ChannelSpacing: carrier + ChannelSpacing * 31;

figure; stem(ShortPreambleIndex, abs(ShortPreamble));