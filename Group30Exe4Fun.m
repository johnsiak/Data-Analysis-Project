%Ioannis Siakavaras
%Christoforos Chatziantoniou

function [CI_Fisher, CI_Boot, p_par, p_perm, n] = Group30Exe4Fun(x, y)

    %removing NaN values
    not_nan = ~isnan(x) & ~isnan(y);
    x = x(not_nan);
    y = y(not_nan); 
    
    n = length(x);

    alpha = 0.05;
    
    r = corr(x, y);

    %calculating confidence interval through Fisher transformation
    z = 0.5 * log( (1+r) / (1-r) );
    z_low = z - (norminv(1 - alpha/2) * sqrt(1 / (n-3))); 
    z_upper = z + (norminv(1 - alpha/2) * sqrt(1 / (n-3)));
    r_low = tanh(z_low);
    r_upper = tanh(z_upper);
    CI_Fisher = [r_low r_upper]; 

    %calculating confidence interval using bootstrap method
    B = 5000;
    CI_Boot = bootci(B, @corr, x, y); 

    %parametric test
    t0 = abs( r * sqrt( (n-2) / (1-r^2) ) );
    p_par = 2*(1 - tcdf(t0, n-2)); 

    %non-parametric test (randomization)
    rho_perm = zeros(1, B);
    for i = 1:B
        x_perm = x(randperm(n));
        rho_perm(i) = corr(x_perm, y);
    end
    p_perm = sum(abs(rho_perm) >= abs(r))/B;

end 