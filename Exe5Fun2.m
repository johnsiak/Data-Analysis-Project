function [I, p, len] = Group30Exe5Fun2(x, y)
    
    I = Group30Exe5Fun1(x, y);

    %removing NaN values
    not_nan = ~isnan(x) & ~isnan(y);
    x = x(not_nan);
    y = y(not_nan); 
    
    B = 2500; %number of random samples
    len = length(x);
    
    %randomization (permutation) method
    perm_Is = zeros(B, 1);
    for i = 1:B
        perm_y = y(randperm(len));
        perm_Is(i) = Group30Exe5Fun1(x, perm_y);
    end
    
    p = sum(perm_Is >= I)/B;
end
