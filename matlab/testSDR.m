clear all;
close all;

load('test200.mat');

t=linspace(0,1,length(cf_ad9361_lpc_voltage0));
figure(1);
hold on;
grid on;
grid minor;

plot(t,cf_ad9361_lpc_voltage0');
load('testORG.mat');
plot(t,cf_ad9361_lpc_voltage0','r');
