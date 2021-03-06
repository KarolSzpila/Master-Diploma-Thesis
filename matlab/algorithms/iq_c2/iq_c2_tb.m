clear all;
close all;

load('C:\Program Files\IIO Oscilloscope\lib\osc\waveforms\sinewave_corrupt_0.3.mat');

len=1000;
sigma = 5;
window_size = 30;


I = real(SignalGen) + 0.2;
Q = imag(SignalGen);

t=linspace(0,1,length(I));

t=linspace(0,1,length(SignalGen));
I = sin(2*pi*1000*t);
Q= cos(2*pi*1000*t);
[Icorr, Qcorr] = iq_c2(I', Q');


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
plot(t(1:len),Icorr(1:len))
plot(t(1:len), Qcorr(1:len))

figure(2)
subplot(1,2,1)
hold on;
grid on;
grid minor;
plot(I,Q)
subplot(1,2,2)
hold on;
grid on;
grid minor;
plot(Icorr, Qcorr);