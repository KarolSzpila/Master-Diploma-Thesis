clear all;
close all;
av=100;
load('C:\Program Files\IIO Oscilloscope\lib\osc\waveforms\sinewave_corrupt_0.3.mat');

t=linspace(0,1,1000);

I = 2000*sin(2*pi*10000*t);
Q = 1000*cos(2*pi*10000*t);

figure(1)

subplot(1,2,1);
hold on;
grid on;
grid minor;
plot(t,I);
plot(t,Q);

EI = moving_average_fir(I.*I,av);
EQ = moving_average_fir(Q.*Q,av);
EIQ = moving_average_fir(I.*Q,av);

R1 = EIQ./(EI.*EQ);
R2 = sqrt(EI./EQ);

e = ((R2 - 1)./(1+R2))';
Icorr = (1-e).*I(1:end-av);
Qcorr = (1+e).*Q(1:end-av);
subplot(1,2,2);
hold on;
grid on;
grid minor;
plot(t(1:length(Icorr)),Icorr);
plot(t(1:length(Icorr)),Qcorr);

dfi = asin(R1);






