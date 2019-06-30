function [ x_corr ] = gauss_smooth( x, sigma, window_size )
    x_corr = zeros(1,length(x) - window_size);
    y = linspace(-window_size / 2, window_size / 2, window_size);
    gaussFilter = exp(-y .^ 2 / (2 * sigma ^ 2));
    gaussFilter = gaussFilter / sum (gaussFilter); % normalize
    gaussFilter'
    for i=1 : length(x_corr) - window_size
        prev_x = x(i:i+window_size-1);
        x_corr(i) = sum(gaussFilter.*prev_x');
    end
    x_corr = x_corr';
end

 