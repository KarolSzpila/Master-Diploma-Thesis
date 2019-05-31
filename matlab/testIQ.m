clear all;
close all;

len = 1000;

load('C:\Program Files\IIO Oscilloscope\lib\osc\waveforms\sinewave_corrupt_0.3.mat');

I = real(SignalGen);
Q = imag(SignalGen);

t=linspace(0,1,length(I));


pQ = zeros(length(Q),1);
pI = zeros(length(Q),1);
%Iq = 4095*sin(2*pi*1000*t);
%Qp = 4095*cos(2*pi*1000*t+pi/12);

Iq = sin(2*pi*1000*t);
Qp = cos(2*pi*1000*t + pi/12) + 0.3;

z = Iq./Qp;

figure(2)
hold on;
grid on;
grid minor;
plot(t,z);


pd = phdiffmeasure(Iq,Qp) * 180/pi;


figure();
hold on;
grid on;
grid minor;
plot(t,Iq,'r');
plot(t,Qp);
SignalGen = complex(Iq',Qp');
save('C:\Program Files\IIO Oscilloscope\lib\osc\waveforms\sinewave_corrupt_0.3.mat','SignalGen');