function [ Iend, Qend ] = iq_corr_mav( I, Q, step) 
    range = 1;
    bI = moving_average_fir( I, step);
    bQ = moving_average_fir( Q, step);
    
    I_corr = I(step+1:end) - bI;
    Q_corr = Q(step+1:end) - bQ;
    
    
    Ipp = moving_average_fir( I_corr.*I_corr, step )/(range.^2);
    alpha = sqrt(2*Ipp);
    
    IQpp = moving_average_fir(I_corr.*Q_corr, step)/(range.^2);
    sinw = (2./alpha) .* IQpp;
    cosw = sqrt(1 - sinw.*sinw);
    
    A = 1./alpha;
    C = (-sinw)./(alpha.*cosw);
    D = 1./cosw;
    
    Iend = A.*I_corr(step+1:end);
    Qend = A.*(C.*I_corr(step+1:end) + D.*Q_corr(step+1:end));
end

