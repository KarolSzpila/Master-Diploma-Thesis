clear all;
close all;

Fs = 200;            % Sampling frequency                    
T = 1/Fs;             % Sampling period       
L = 1000;             % Length of signal
t = (0:L-1)*T;        % Time vector

I = chirp(t(1),10,t(end),50);

I = I + 0.01*randn(1,length(I));
Q = Q + 0.01*randn(1,length(Q));

%[I, Q] = iq_corr(I', Q');
S = complex(I,Q);

pd = phdiffmeasure(Q,I) * 180/pi - 90;

Y = fftshift(fft(S)/length(S));

figure(2)
hold on;
grid on;
grid minor;


figure(1)
hold on;
grid on;
grid minor;
%P2 = abs(Y/L);
%P1 = P2;%(1:L/2+1);
%P1(2:end-1) = 2*P1(2:end-1);
df = Fs/length(Y);
f = -Fs/2+df:df:Fs/2;
plot(f,mag2db(abs(Y)))
xlabel('Hz');
% %f = Fs*(0:(L/2))/L;
% f = Fs*(0:(L))/L;
% plot(f(1:length(P1)),P1);
% title('Single-Sided Amplitude Spectrum of X(t)')
% xlabel('f (Hz)')
% ylabel('|P1(f)|')
