clear; close all;

%% Param
fs = 128;
A = [0; 0; 1];
fc = [-2; 0; 2];
T = 10;


%% mod
t = (0: 1/fs : T - 1/fs).';
S1 = exp(2j*pi*t*fc.') * A;


%% demod
phase_rx = angle(conj([S1; 0]) .* [0; S1]);
fc_rx = - phase_rx * fs / 2 / pi; 
mean(fc_rx)

figure; plot(t, real(S1)); hold on; plot(t, imag(S1)); title('S = exp(2j*pi*fc*t)');
figure; stem(phase_rx); title('phase');
figure; stem(fc_rx); title('fc\_rx');