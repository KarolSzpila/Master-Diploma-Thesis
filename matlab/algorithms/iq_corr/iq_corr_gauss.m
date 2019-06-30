function [ Iend, Qend ] = iq_corr_gauss( I, Q, sigma, step) 
    range = 1;
    
    bI = gauss_smooth( I, sigma, step);
    bQ = gauss_smooth( Q, sigma, step);
    
    I_corr = I(step+1:end) - bI;
    Q_corr = Q(step+1:end) - bQ;
    
    av_step = 256;
    Ipp = moving_average_fir( I_corr.*I_corr, av_step )/(range.^2);
    alpha = sqrt(2*Ipp);
    
    IQpp = moving_average_fir(I_corr.*Q_corr, av_step)/(range.^2);
    sinw = (2./alpha) .* IQpp;
    cosw = sqrt(1 - sinw.*sinw);
    
    A = 1./alpha;
    C = (-sinw)./(alpha.*cosw);
    D = 1./cosw;
    
    Iend = A.*I_corr(av_step+1:end);
    Qend = A.*(C.*I_corr(av_step+1:end) + D.*Q_corr(av_step+1:end));
end