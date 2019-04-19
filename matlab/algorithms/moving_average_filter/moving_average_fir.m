function [ x_corr ] = moving_average_fir( x, order )

    x_corr = zeros(1,length(x) - order)';
    for i=1 : length(x_corr)
        prev_x = x(i:i+order - 1);
        x_corr(i) = sum(prev_x)/order;
    end
end