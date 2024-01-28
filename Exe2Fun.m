function [mean_par, mean_boot] = Group30Exe2Fun(sampleData)
    [~, ~, mean_par] = ttest(sampleData); 
    mean_boot = bootci(2500, @mean, sampleData);   
end
