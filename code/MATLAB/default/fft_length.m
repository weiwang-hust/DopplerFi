clear; close all;

%% OFDM Param
SC_DATA_INDEX   = [2:7 9:21 23:27 39:43 45:57 59:64]; 
SC_PILOT_INDEX  = [8 22 44 58];
N_SC            = 64;
N_SC_DATA       = 48;
CP_LEN          = 16;
PILOT           = [1, -1, 1, 1].';
MOD_ORDER       = 2; % 2/4/16/64

%% Param
N_SYMBOL = 50;
NumData = N_SYMBOL * N_SC_DATA;

%% random data
raw_data_TX = randi(MOD_ORDER, N_SC_DATA * N_SYMBOL, 1) - 1;
switch MOD_ORDER
    case 2
        mod_data_TX = step(comm.BPSKModulator, raw_data_TX);
    case 4
        mod_data_TX = step(comm.QPSKModulator, raw_data_TX);
    case 16
        mod_data_TX = step(comm.RectangularQAMModulator, raw_data_TX);
    case 64
        mod_data_TX = step(comm.RectangularQAMModulator('ModulationOrder', 64) , raw_data_TX);       
    otherwise
        error('MOD_METHOD must be 2/4/16/64');
end

%% TX
OFDM_TX_f = zeros(N_SC, N_SYMBOL);
OFDM_TX_f(SC_DATA_INDEX, :) = reshape(mod_data_TX, N_SC_DATA, N_SYMBOL);
OFDM_TX_f(SC_PILOT_INDEX, :) = repmat(PILOT, 1, N_SYMBOL);

OFDM_TX_t = reshape(ifft(OFDM_TX_f), [], 1);

%% RX
OFDM_RX_t = OFDM_TX_t;

OFDM_RX_FS = fft(OFDM_RX_t);

figure; plot(abs(OFDM_RX_FS)); title('amplitude of OFDM RX frequency spectrum');
% figure; stem(angle(OFDM_RX_FS)); title('angle of OFDM RX frequency spectrum');

%% FSK Demod
fs = 312.5;
phase_rx = angle(conj([OFDM_RX_t; 0]) .* [0; OFDM_RX_t]);

fc_rx = - phase_rx * fs / 2 / pi; 
mean(fc_rx)
