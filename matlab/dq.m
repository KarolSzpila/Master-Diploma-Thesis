clear all;
close all;

Fs = 400;            % Sampling frequency                    
T = 1/Fs;             % Sampling period       
L = 1000;            % Length of signal
t = (0:L-1)*T;        % Time vector
f = 100;
%I = chirp(t,10,t(end),50);
%Q = chirp(t,10,t(end),50,'linear',-90 + 20);

f1 = 100;

offset = 0.1;
fi = pi/60;

I = cos(2*pi*f1*t) + cos(2*pi*t*f2) + offset;
Q = sin(2*pi*f1*t + fi) + sin(2*pi*f2*t + fi);

%I = I + 0.01*randn(1,length(I));
%Q = Q + 0.01*randn(1,length(Q));

[I, Q] = iq_corr_gauss(I', Q',5,50);

S = complex(I,Q);

%pd = phdiffmeasure(Q,I) * 180/pi - 90;
Y = fftshift(fft(S)/length(S));

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
