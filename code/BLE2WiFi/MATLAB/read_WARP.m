function ComplxCSI = read_WARP(filename)

fid = fopen(filename);
data = fread(fid, 'float');
data = reshape(data, 2, []).';
ComplxCSI = data(:, 1) + 1j * data(:, 2);
fclose(fid);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure; plot(abs(ComplxCSI));
buffer = ComplxCSI(64*21+1: 64*21+64*42);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

ComplxCSI = reshape(ComplxCSI, 64, []);

buffer = ifft(fftshift(reshape(buffer, 64, [])));

buffer = reshape(buffer, [], 1);

% figure; plot(abs(fft(buffer)));
ComplxCSI = ComplxCSI(:, 1: 15: end);