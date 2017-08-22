
n = 0: 1: 8;
A1 = -1-j;
A2 = 1+j;

delta = -0.13;
% delta = 0.1;

f1 = -0.5 + delta;
f2 = 0.75 + delta;
fs = 2;

if f1 < -1
    f1 = 0;
end

x1 = A1 * exp(j*2*pi*f1/fs*n).' + A2 * exp(j*2*pi*f2/fs*n).';

y1 = angle([0; x1] .* conj([x1; 0]));

% figure; plot(abs(fft(x)));

% figure; plot(real(x1)); hold on; plot(imag(x1));
% figure; stem(y1(2: end-1));
% sum(length(find(y1(2: end-1) < 0)))
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
A = [ -1 1 1 -1 1 -1 1];

% delta = 0.13;
% delta = -0.1;

f0 = 0.3125;
f = [ -3 -2 -1 0 1 2 3] * f0 + delta;

fs = 2;

x2 = exp(j*2*pi*n.'*f/fs) * (A.');
y2 = angle([0; x2] .* conj([x2; 0]));

% sum(y(2: end-1))

% figure; plot(real(x2)); hold on; plot(imag(x2));
% figure; stem(y2(2: end-1));
% sum(length(find(y2(2: end-1) < 0)))


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

x = [x1; x2];

y = angle([0; x] .* conj([x; 0]));
% figure; plot(real(x)); hold on; plot(imag(x));
figure; stem(y(2: end-1));
sum(length(find(y(2: end-1) <= 0)))