%Ioannis Siakavaras
%Christoforos Chatziantoniou

function I = Group30Exe5Fun1(x, y)

    %removing NaN values
    not_nan = ~isnan(x) & ~isnan(y);
    x = x(not_nan);
    y = y(not_nan); 
    
    n = length(x);

    %discretizing x and y based on the median
    x_median = median(x);
    y_median = median(y);
    x_discrete = double(x < x_median);
    y_discrete = double(y < y_median);
    
    %calculating probability distribution functions using histograms by
    %dividing occurrences of each value in the data by the total 
    %number of data points
    fX = histcounts(x_discrete)/n; %1x2 double
    fY = histcounts(y_discrete)/n; %1x2 double
    %we use a 2-dimensional histogram because we want to calculate the joint probability
    fXY = histcounts2(x_discrete, y_discrete)/n; %2x2 double
    
    %calculating entropies
    HX = -fX * log10(fX)'; %we use ' because multiplication between matrices only works with certain dimensions
    HY = -fY * log10(fY)';
    HXY = -fXY(:) .* log10(fXY(:)); %fXY(:) because we want to make fXY a vector (it's a 2x2 array originally)
    HXY = sum(HXY(~isinf(HXY))); %we excluse the entropies that are 0 because log10(0) is infinity
    
    I = HX + HY - HXY;
    
end