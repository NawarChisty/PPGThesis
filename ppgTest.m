%%
load('s6_walkm.mat');
signal = val';
original = signal;
bandpassSignal = butterworth(signal);
%bandpassSignal = savgol(bandpassSignal);

x = ((0:length(signal)-1)/256);
xf = linspace(0, 256, length(bandpassSignal));

%figure
%subplot(2,1,1)
%plot(x, original);
%title("Raw PPG Signal");
%subplot(2,1,2)
%plot(x, bandpassSignal)
%title("After Bandpass");


%%
load('s6_walkm-gyro-x.mat');
signalX = val';
originalX = signalX;
bandpassSignalX = butterworth(signalX);


load('s6_walkm-x.mat');
signalaX = val';
originalaX = signalaX;
bandpassSignalaX = butterworth(signalaX);


adaptiveX = adaptive(originalX, bandpassSignalX);
adaptiveaX = adaptive(originalaX, bandpassSignalaX);
%adaptiveaX = savgol(adaptiveaX);
%adaptiveX = savgol(adaptiveX);

newadaptiveX = adaptiveaX - adaptiveX;

sX = newadaptiveX - bandpassSignal;

Sx = stft(sX);
Sxf = linspace(0, 256, length(Sx));

Sx = Sx.*conj(Sx)/251;


%figure
%plot(x, bandpassSignal, x, bandpassSignalX, x, bandpassSignalaX);
%legend('PPG', 'Gyroscope Signal', 'Acceleration Signal');


%figure
%subplot(5,1,1);
%plot(xf, bandpassSignalX);
%subplot(5,1,2);
%plot(xf, bandpassSignalaX);
%subplot(5,1,3)
%plot(xf, newadaptiveX);
%subplot(5,1,4);
%plot(xf, abs(sX));
%subplot(5,1,5);
%plot(Sxf, abs(Sx));




%%
load('s6_walkm-gyro-y.mat');
signalY = val';
originalY = signalY;
bandpassSignalY = butterworth(signalY);

load('s6_walkm-y.mat');
signalaY = val';
originalaY = signalaY;
bandpassSignalaY = butterworth(signalaY);

adaptiveY = adaptive(originalY, bandpassSignalY);
adaptiveaY = adaptive(originalaY, bandpassSignalaY);

%adaptiveY = savgol(adaptiveY);
%adaptiveaY = savgol(adaptiveaY);

newadaptiveY = adaptiveaY - adaptiveY;

sY = newadaptiveY - bandpassSignal;

Sy = stft(sY);
Syf = linspace(0, 256, length(Sy));

Sy = Sy.*conj(Sy)/251;

%figure
%subplot(5,1,1);
%plot(xf, bandpassSignalY);
%subplot(5,1,2);
%plot(xf, bandpassSignalY);
%subplot(5,1,3)
%plot(xf, newadaptiveY);
%subplot(5,1,4);
%plot(xf, abs(sY));
%subplot(5,1,5);
%plot(Syf, abs(Sy));



%%
load('s6_walkm-gyro-z.mat');
signalZ = val';
originalZ = signalZ;
bandpassSignalZ = butterworth(signalZ);

load('s6_walkm-z.mat');
signalaZ = val';
originalaZ = signalaZ;
bandpassSignalaZ = butterworth(signalaZ);

adaptiveZ = adaptive(originalZ, bandpassSignalZ);
adaptiveaZ = adaptive(originalaZ, bandpassSignalaZ);

%adaptiveY = savgol(adaptiveY);
%adaptiveaY = savgol(adaptiveaY);

newadaptiveZ = adaptiveaZ - adaptiveZ;

sZ = newadaptiveZ - bandpassSignal;

Sz = stft(sZ);
Szf = linspace(0, 256, length(Sz));

Sz = Sz.*conj(Sz)/251;

%figure
%subplot(5,1,1);
%plot(xf, bandpassSignalZ);
%subplot(5,1,2);
%plot(xf, bandpassSignalZ);
%subplot(5,1,3)
%plot(xf, newadaptiveZ);
%subplot(5,1,4);
%plot(xf, abs(sZ));
%subplot(5,1,5);
%plot(Szf, abs(Sz));




%%
Snf = ((Sx * Sy')*Sz) .^ (2/3); 

Snf = Snf/ max( abs(Snf ));
figure
plot(Szf, abs(Snf), 'LineWidth', 2);
title("After Spectrum Multiplication");
xlabel("Frequency");
ylabel("Magnitude");

maxSnf = max(Snf);  % Find max value over all elements.
indexOfFirstMax = find(Snf == maxSnf, 1, 'first');  % Get first element that is the max.

BPM = ((indexOfFirstMax - 1)/length(Snf) * 256 * 60);
x1 = ((0:length(Snf)-1)/256);

%%

figure
subplot(4,1,1);
plot(x, original, 'LineWidth', 2);
title("Raw PPG Sampled at 256 Hz");
xlabel("Time")
ylabel("Amplitude");

subplot(4,1,2);
plot(x, originalaX, x, originalX, 'LineWidth', 2);
title("Raw Acc and Gyro Signal-x Sampled at 256 Hz");
xlabel("Time")
ylabel("Amplitude");
legend('Acc Signal', 'Gyro Signal');

subplot(4,1,3);
plot(x, originalaY, x, originalY, 'LineWidth', 2);
title("Raw Acc and Gyro Signal-y Sampled at 256 Hz");
xlabel("Time")
ylabel("Amplitude");
legend('Acc Signal', 'Gyro Signal');

subplot(4,1,4);
plot(x, originalaZ, x, originalZ, 'LineWidth', 2);
title("Raw Acc and Gyro Signal-z Sampled at 256 Hz");
xlabel("Time")
ylabel("Amplitude");
legend('Acc Signal', 'Gyro Signal');

%%
figure

subplot(3,1,1)
plot(x, sX, 'LineWidth', 2)
title("After Subtraction, x-axis");
ylabel("Amplitude")
subplot(3,1,2)
plot(x, sY, 'LineWidth', 2)
title("After Subtraction, y-axis");
ylabel("Amplitude")
subplot(3,1,3)
plot(x, sZ, 'LineWidth', 2)
title("After Subtraction, z-axis");
ylabel("Amplitude")
xlabel("Time")

%%
figure
subplot(3,1,1)
plot(Sxf, abs(Sx), 'LineWidth', 2)
title("After Short Time Fourier Transform, x-axis");
ylabel("Amplitude");
subplot(3,1,2)
plot(Syf, abs(Sy), 'LineWidth', 2)
title("After Short Time Fourier Transform, y-axis");
ylabel("Amplitude");
subplot(3,1,3)
plot(Szf, abs(Sz), 'LineWidth', 2)
title("After Short Time Fourier Transform, z-axis");
ylabel("Amplitude");
xlabel("Frequency");

figure
subplot(3,1,1)
plot(x, bandpassSignal, 'LineWidth', 2)
title("Preprocessing PPG signal")
xlabel("Amplitude")
subplot(3,1,2)
plot(x, adaptiveX, 'LineWidth', 2)
title("Preprocesssing Gyro-x")
xlabel("Amplitude")
subplot(3,1,3)
plot(x, adaptiveaX, 'LineWidth', 2)
title("Preprocessing Acc-x")
ylabel("Time")
xlabel("Amplitude")

