clear all;
close all;

len=1000;
sigma = 5;
window_size = 30;

load('C:\Program Files\IIO Oscilloscope\lib\osc\waveforms\sinewave_corrupt_0.3.mat');

I = real(SignalGen);
Q = imag(SignalGen);

t=linspace(0,1,length(I));

dcI = 0.1;
dcQ = 0;

I = I + dcI;
Q = Q + dcQ;


Icorr = gauss_smooth(I, sigma, window_size);
Qcorr = gauss_smooth(Q, sigma, window_size);

figure(1)
subplot(2,1,1)
hold on;
grid on;
grid minor;
plot(t(1:len),I(1:len))
plot(t(1:len),Q(1:len))
xlabel('time [s]');
ylabel('Amplitude');
subplot(2,1,2)
hold on;
grid on;
grid minor;
xlabel('time [s]');
ylabel('Amplitude');
plot(t(window_size:len),I(window_size:len) - Icorr(window_size:len))
plot(t(window_size:len),Q(window_size:len) - Qcorr(window_size:len))

figure(2)
subplot(1,2,1)
hold on;
grid on;
grid minor;
axis([-1.5 1.5 -1.5 1.5])
plot(I(1:len),Q(1:len));
plot([1.5 -1.5],[0 0],'k--');
plot([0 0],[1.5 -1.5],'k--');

subplot(1,2,2)
hold on;
grid on;
grid minor;
plot(I(window_size:len) - Icorr(window_size:len),Q(window_size:len) - Qcorr(window_size:len));
axis([-1.5 1.5 -1.5 1.5])
plot([1.5 -1.5],[0 0],'k--');
plot([0 0],[1.5 -1.5],'k--');
