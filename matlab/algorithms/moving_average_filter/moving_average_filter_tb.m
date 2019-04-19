clear all;
close all;

len = 1000;
av = 100;

load('C:\Program Files\IIO Oscilloscope\lib\osc\waveforms\sinewave_0.3.mat');

I = real(SignalGen);
Q = imag(SignalGen);

dcI = 0;
dcQ = 0;

I = I + dcI;
Q = Q + dcQ;

t=linspace(0,1,length(I));

Icorr = moving_average_fir(I,av);
Qcorr = moving_average_fir(Q,av);
figure(2)
hold on;
grid on;
grid minor;
ipp = I.*I;
qpp = I.*Q;
plot(t(av:len),Icorr(av:len))
plot(t(av:len),Qcorr(av:len))
plot(t(av:len),ipp(av:len))
plot(t(av:len),qpp(av:len))

figure(1)
subplot(2,1,1)
hold on;
grid on;
grid minor;
plot(t(1:len),I(1:len))
plot(t(1:len),Q(1:len))
subplot(2,1,2)
hold on;
grid on;
grid minor;
plot(t(av:len),I(av:len) - Icorr(av:len))
plot(t(av:len),Q(av:len) - Qcorr(av:len))