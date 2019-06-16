clear all;
close all;

Fs = 20000;            % Sampling frequency                    
T = 1/Fs;             % Sampling period       
L = 10000;            % Length of signal
t = (0:L-1)*T;        % Time vector
f = 1000;

offset = 0.1;
fi = pi/6;

I = cos(2*pi*f*t) + offset + 0.1*randn(1,L);
Q = sin(2*pi*f*t + fi) + 0.1*randn(1,L);

order = 256;
window_size = 30;
sigma = 5;

[IcorrMov, QcorrMov] = iq_corr_mav(I',Q',order);
[IcorrGauss, QcorrGauss] = iq_corr_gauss(I',Q',sigma,window_size);

S = complex(I,Q);
Y = fftshift(fft(S)/length(S));
figure(1)
subplot(1,3,1);
hold on;
grid on;
grid minor;
df = Fs/length(Y);
f = -Fs/2+df:df:Fs/2;
plot(f,mag2db(abs(Y)))
title('Input Signal');
xlabel('f [Hz]');
ylabel('dB');

S = complex(IcorrMov,QcorrMov);
Y = fftshift(fft(S)/length(S));
subplot(1,3,2);
hold on;
grid on;
grid minor;
df = Fs/length(Y);
f = -Fs/2+df:df:Fs/2;
plot(f,mag2db(abs(Y)))
title('Moving Average Filter');
xlabel('f [Hz]');
ylabel('dB');

S = complex(IcorrGauss(1:end-200),QcorrGauss(1:end-200));
Y = fftshift(fft(S)/length(S));
subplot(1,3,3);
hold on;
grid on;
grid minor;
df = Fs/length(Y);
f = -Fs/2+df:df:Fs/2;
plot(f,mag2db(abs(Y)))
title('Gaussian Filter');
xlabel('f [Hz]');
ylabel('dB');


figure(2);
subplot(1,3,1);
hold on;
grid on;
grid minor;
xlabel('In-Phase');
ylabel('Quadrature');
title('Input Signal');
xlim([-2 2])
ylim([-2 2])
plot(I,Q,'.');

subplot(1,3,2);
hold on;
grid on;
grid minor;
xlabel('In-Phase');
ylabel('Quadrature');
title('Moving Average Filter');
xlim([-2 2])
ylim([-2 2])
plot(IcorrMov,QcorrMov,'.');

subplot(1,3,3);
hold on;
grid on;
grid minor;
xlabel('In-Phase');
ylabel('Quadrature');
title('Gaussian Filter');
xlim([-2 2])
ylim([-2 2])
plot(IcorrGauss(1:end-100)*0.8,QcorrGauss(1:end-100)*0.8,'.');