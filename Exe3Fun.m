function [p_param, p_boot] = Group30Exe3Fun(years, x)

    for i=1:(length(years) - 1)
        if((years(i+1) - years(i)) ~= 1)
            cutoff = i;
            break
        end

        %if we have read the entirety of the years vector and we haven't found a cutoff
        if(i == (length(years) - 1)) 
            error('Exiting the function');
        end
    end
    
    X1 = x(1:cutoff);
    X1 = X1(~isnan(X1)); %removing NaN values

    X2 = x(cutoff+1:length(x));
    X2 = X2(~isnan(X2)); %removing NaN values
    
    %parametric
    [~, p_param, ~] = ttest2(X2,X1);
    
    %permutation (randomization) method
    mean_diff = mean(X1) - mean(X2);
    data = [X1; X2]; 
    B = 5000; %number of random samples
    n1 = length(X1);
    n2 = length(X2);
    mean_diff_random = zeros(B,1);
    for i = 1:B
        data = data(randperm(length(data)));
        random_sample1 = data(1:n1);
        random_sample2 = data(n1+1:n1+n2);
        mean_diff_random(i) = mean(random_sample1) - mean(random_sample2);
    end

    %return the p-values of the randomization test
    p_boot = mean(mean_diff_random >= mean_diff);

end
