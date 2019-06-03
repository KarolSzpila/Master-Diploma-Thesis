clear all;
close all;

len = 1000;
av = 256;

load('C:\Program Files\IIO Oscilloscope\lib\osc\waveforms\sinewave_corrupt_0.3.mat');

I = real(SignalGen);
Q = imag(SignalGen);

dcI = 0;
dcQ = 0 + 0.2;

I = I + dcI + 0.01*randn(length(I),1);
Q = Q + dcQ + 0.01*randn(length(I),1);

t=linspace(0,1,length(I));

Icorr = moving_average_fir(I,av);
Qcorr = moving_average_fir(Q,av);

figure(1)
subplot(2,1,1)
hold on;
grid on;
grid minor;
xlabel('time [s]');
ylabel('Amplitude');
title('Imbalanced signal');
plot(t(1:len),I(1:len))
plot(t(1:len),Q(1:len))
subplot(2,1,2)
hold on;
grid on;
grid minor;
xlabel('time [s]');
ylabel('Amplitude');
title('Signal after DC offset correction')
plot(t(av:len),I(av:len) - Icorr(av:len))
plot(t(av:len),Q(av:len) - Qcorr(av:len))

figure(2)
subplot(1,2,1)
hold on;
grid on;
grid minor;
xlabel('In Phase Amplitude');
ylabel('Quadrature Amplitude');
title('Imbalanced signal');
axis([-1.5 1.5 -1.5 1.5])
plot(I(1:len),Q(1:len));
plot([1.5 -1.5],[0 0],'k--');
plot([0 0],[1.5 -1.5],'k--');

subplot(1,2,2)
hold on;
grid on;
grid minor;
xlabel('In Phase Amplitude');
ylabel('Quadrature Amplitude');
title('Signal after DC offset correction')
plot(I(av:len) - Icorr(av:len),Q(av:len) - Qcorr(av:len));
axis([-1.5 1.5 -1.5 1.5])
plot([1.5 -1.5],[0 0],'k--');
plot([0 0],[1.5 -1.5],'k--');


max(I(av:len) - Icorr(av:len))
max(Q(av:len) - Qcorr(av:len))
