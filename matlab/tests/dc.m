clear all;
close all;

Fs = 40000;            % Sampling frequency                    
T = 1/Fs;             % Sampling period       
L = 10000;            % Length of signal
t = (0:L-1)*T;        % Time vector
f = 1000;

offset = 0.1;

I = cos(2*pi*f*t) + offset;
Q = sin(2*pi*f*t);

order = 256;
sigma = 5;
window_size = 30;
showlen = 700;

mov_Ioff = moving_average_fir(I', order)';
mov_Qoff = moving_average_fir(Q', order)';

IcorrMov = I(order+1:L) - mov_Ioff;
QcorrMov = Q(order+1:L) - mov_Qoff;

gauss_Ioff = gauss_smooth(I', sigma, window_size)';
gauss_Qoff = gauss_smooth(Q', sigma, window_size)';

IcorrGauss = I(window_size+1:L) - gauss_Ioff;
QcorrGauss = Q(window_size+1:L) - gauss_Qoff;
tGauss = t(window_size+1:L);


figure(1);
subplot(3,1,1)
hold on;
grid on;
grid minor;
title('Input Signal');
xlabel('time [s]');
ylabel('Amplitude');
plot(t(1:showlen),I(1:showlen))
plot(t(1:showlen),Q(1:showlen))

subplot(3,1,2)
hold on;
grid on;
grid minor;
title('Moving Average Filter');
xlabel('time [s]');
ylabel('Amplitude');
plot(t(order:showlen),IcorrMov(1:showlen-order+1))
plot(t(order:showlen),QcorrMov(1:showlen-order+1))

subplot(3,1,3)
hold on;
grid on;
grid minor;
title('Gaussian Filter');
xlabel('time [s]');
ylabel('Amplitude');
plot(t(window_size:showlen),IcorrGauss(1:showlen-window_size+1))
plot(t(window_size:showlen),QcorrGauss(1:showlen-window_size+1))

S = complex(I,Q);
Y = fftshift(fft(S)/length(S));
figure(2)
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

figure(3);
subplot(1,3,1);
hold on;
grid on;
grid minor;
xlabel('In-Phase');
ylabel('Quadrature');
title('Input Signal');
plot(I,Q);

figure(3);
subplot(1,3,2);
hold on;
grid on;
grid minor;
xlabel('In-Phase');
ylabel('Quadrature');
title('Moving Average Filter');
plot(IcorrMov,QcorrMov);

figure(3);
subplot(1,3,3);
hold on;
grid on;
grid minor;
xlabel('In-Phase');
ylabel('Quadrature');
title('Gaussian Filter');
plot(IcorrGauss(1:end-100),QcorrGauss(1:end-100));
