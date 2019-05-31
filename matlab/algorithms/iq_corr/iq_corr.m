function [ Iend, Qend ] = iq_corr( I, Q )
    step = 100;
    range = 4096;
    bI = moving_average_fir( I, step);
    bQ = moving_average_fir( Q, step);
    
    %bI = gauss_smooth( I, sigma, step);
    %bQ = gauss_smooth( Q, sigma, step);
    
    I_corr = I(step+1:end) - bI;
    Q_corr = Q(step+1:end) - bQ;
    
    
    Ipp = moving_average_fir( I_corr.*I_corr, step )/(range.^2);
    %Ipp = gauss_smooth( I_corr.*I_corr, sigma, step);
    alpha = sqrt(2*Ipp);
    
    IQpp = moving_average_fir(I_corr.*Q_corr, step)/(range.^2);
    %IQpp = gauss_smooth( I_corr.*Q_corr, sigma, step);
    sinw = (2./alpha) .* IQpp;
    cosw = sqrt(1 - sinw.*sinw);
    
    A = 1./alpha;
    C = (-sinw)./(alpha.*cosw);
    D = 1./cosw;
    
    Iend = A.*I_corr(step+1:end);
    Qend = A.*(C.*I_corr(step+1:end) + D.*Q_corr(step+1:end));
end

