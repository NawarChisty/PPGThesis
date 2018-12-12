function [ output ] = stft(signal)
wlen = 2048;                        % window length (recomended to be power of 2)
noverlap = 2048/8;                    
nfft = 4096; 
fs = 256;
window = hamming(wlen);

[S, F, T] = spectrogram(signal, wlen, noverlap, nfft, fs);

output = abs(S);


set(gca,'YDir','Normal')
%title('Short-time Fourier Transform spectrum')

end