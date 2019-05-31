clear all;
close all;

Fs = 500;            % Sampling frequency                    
T = 1/Fs;             % Sampling period       
L = 1500;             % Length of signal
t = (0:L-1)*T;        % Time vector

I = sin(2*pi*100*t);
Q = sin(2*pi*100*t+pi/2);

S = complex(I,Q);
X = S;


Y = fft(X);
P2 = abs(Y/L);
P1 = P2(1:L/2+1);
P1(2:end-1) = 2*P1(2:end-1);

figure(1)
hold on;
grid on;
grid minor;
f = Fs*(0:(L/2))/L;
plot(f,P1);
title('Single-Sided Amplitude Spectrum of X(t)')
xlabel('f (Hz)')
ylabel('|P1(f)|')
