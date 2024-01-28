%Ioannis Siakavaras
%Christoforos Chatziantoniou

function [adjRsq, p_perm] = Group30Exe8Fun(x, y)

    %erase NaN values
    not_nan = ~isnan(x) & ~isnan(y);
    x = x(not_nan);
    y = y(not_nan);

    %second degree polynomial model
    b = polyfit(x, y, 2);
    yfit = polyval(b, x);

    n = length(y);
    B = 5000;

    %calculating adjusted R-squared
    Rsq = 1 - sum((y-yfit).^2)/sum((y-mean(y)).^2);
    adjRsq = 1 - ((1 - Rsq) * (n - 1)/(n - 2 - 1)); 

    %test with randomization method
    adjRsq_perm = zeros(1, B);
    for i = 1:B
        x_perm = x(randperm(n));
        b_perm = polyfit(x_perm, y, 2);
        yfit_perm = polyval(b_perm, x_perm);
        Rsq_perm = 1 - sum((y-yfit_perm).^2)/sum((y-mean(y)).^2);
        adjRsq_perm(i) = 1 - ((1 - Rsq_perm) * (n - 1)/(n - 2 - 1));
    end
    p_perm = sum(abs(adjRsq_perm) >= abs(adjRsq))/B;   % calculating p-value

end