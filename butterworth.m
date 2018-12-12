function [ output ] = butterworth(signal)

[b, a] = butter(4, [0.0039 0.0391], 'bandpass');

output = filter(b, a, signal);

end
