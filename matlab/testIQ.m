clear all;
close all;

len = 1000;

load('C:\Program Files\IIO Oscilloscope\lib\osc\waveforms\sinewave_corrupt_0.3.mat');

Fs = 40000;            % Sampling frequency                    
T = 1/Fs;             % Sampling period       
L = 10000;            % Length of signal
t = (0:L-1)*T;        % Time vector

f = 1000; 
offset = 0.1;
fi = 0;

Iq = cos(2*pi*f*t) + offset;
Qp = sin(2*pi*f*t + fi);

figure();
hold on;
grid on;
grid minor;
plot(t,Iq,'r');
plot(t,Qp);
SignalGen = complex(Iq',Qp');
save('C:\Program Files\IIO Oscilloscope\lib\osc\waveforms\sinewave_corrupt_0.3.mat','SignalGen');