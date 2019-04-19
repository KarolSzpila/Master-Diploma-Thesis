function [ Iend, Qend ] = iq_c2( I, Q )
    step = 256;
   
    bI = moving_average_fir( I, step);
    bQ = moving_average_fir( Q, step);
    
    I_corr = I(step+1:end) - bI;
    Q_corr = Q(step+1:end) - bQ;
    
    
    O1 = -1.*moving_average_fir(sign(I_corr).*Q_corr, step);
    O2 = bI(step+1:end);
    O3 = bQ(step+1:end);

    c1 = O1./O2;
    c2 = sqrt( (O3.*O3 - O1.*O1)./(O2.*O2) );

    Iend = c2.*I(step+step+1);
    Qend = c1.*I(step+step+1) + Q(step+step+1);
end

