clear all;
close all;

Fs = 8000;            % Sampling frequency                    
T = 1/Fs;             % Sampling period       
L = 10000;            % Length of signal
t = (0:L-1)*T;        % Time vector

f1 = 1000;
f2 = 500;

offset = 0.1;
fi = pi/60;

I = cos(2*pi*f1*t) + cos(2*pi*t*f2) + offset;
Q = sin(2*pi*f1*t + fi) + sin(2*pi*f2*t + fi);

order = 256                       ;
window_size = 15;
sigma = 5;

I = I + 0.1*randn(1,length(I));
Q = Q + 0.1*randn(1,length(Q));

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
xlim([-2.5 2.5])
ylim([-2.5 2.5])
plot(I,Q,'.');

subplot(1,3,2);
hold on;
grid on;
grid minor;
xlabel('In-Phase');
ylabel('Quadrature');
title('Moving Average Filter');
xlim([-2.5 2.5])
ylim([-2.5 2.5])
plot(IcorrMov,QcorrMov,'.');

subplot(1,3,3);
hold on;
grid on;
grid minor;
xlabel('In-Phase');
ylabel('Quadrature');
title('Gaussian Filter');
xlim([-2.5 2.5])
ylim([-2.5 2.5])
plot(IcorrGauss(1:end-100)*0.8,QcorrGauss(1:end-100)*0.8,'.');