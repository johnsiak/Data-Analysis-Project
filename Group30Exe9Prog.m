%Ioannis Siakavaras
%Christoforos Chatziantoniou

clear all
clc

Ta = readmatrix('Heathrow.xlsx');
%we get the data for the years after 1973
Ta = Ta(11:55,2:12);

nanRows = isnan(Ta); %create a logical matrix with true for NaN values and false for non-NaN values
Ta(any(nanRows,2),:) = []; %remove all rows that contain NaN values

T = Ta(:,1);
TM = Ta(:,2);
Tm = Ta(:,3);
PP = Ta(:,4);
V = Ta(:,5);
RA = Ta(:,6);
SN = Ta(:,7);
TS = Ta(:,8);
FG = Ta(:,9);
TN = Ta(:,10);
GR = Ta(:,11);

arr = [FG, GR];
arr1 = ["FG" "GR"];

for i = 1:2  %this part will be executed once for FG and once for GR 
    
    y = arr(:,i); 
    X = [T TM Tm PP V RA SN TS FG TN GR];
    if i==1
        X(:,9) = []; %we do not want to have the same dependent and independent variable
    elseif i==2
        X(:,11) = [];
    end

    %multiple linear regression model
    XX = [ones(size(X(:,1))) X]; 
    b = regress(y, XX);
    yfit = XX*b;
    n = length(XX(:,1));
    e = y - yfit;           %calculate standard error
    SSresid = sum(e.^2);
    SStotal = (n-1) * var(y);
    var_e = (1/(n-10-1)) * SSresid;  %calculate error variance
    Rsq = 1 - SSresid/SStotal;  %R-squared
    adjRsq = 1 - SSresid/SStotal * (n-1)/(n-length(b)-1);  %adjusted R-squared

    %print error variance, R-squared and adjusted R-squared for each case
    fprintf("%s:\n\n", arr1(i));
    fprintf("Linear Regression:\n");
    fprintf("Error Variance: %f\n", var_e);
    fprintf("Rsq = %f\n", Rsq);
    fprintf("AdjRsq = %f\n", adjRsq);
    
    %in the following models RMSE is automatically printed instead of error_variance
    %it should be noted that error_variance = RMSE^2

    %linear regression 2nd method (it does everything we did above automatically)
    linear_regression = fitlm(X, y);
    display(linear_regression);

    %stepwise regression 
    stepwise_regression = stepwiselm(X, y);
    display(stepwise_regression);

    %PCA
    [coeff, ~, ~, ~, explained] = pca(X);
    
    %explained is a vector containing the percentage of total variance 
    %in the original data explained by each principal component

    %determine number of components to retain based on the amount of variance explained
    cum_explained = cumsum(explained); %cumulative sum
    num_components = find(cum_explained >= 90, 1); 
    %the selected number of components will be the smallest number of 
    %principal components that explain at least 90% of the variance in the
    %original data.
    
    %use the selected number of components to reduce the dimension of X
    X_reduced = X * coeff(:, 1:num_components);
    
    PCA_regression = fitlm(X_reduced, y);
    display(PCA_regression);

    fprintf("=================================================================\n");
end

%for both FG and GR the stepwise model is better than the complete model
%and the PCA model as the adjusted-r^2 is bigger. 
%plus, the error variance is the smallest in the stepwise model compared to
%the other ones.
%all in all, the stepwise model is recommended because when we use only 2
%pointers we get a better result compared to the complete model (which has 
%similar values of the adj-r^2 and var_error) and the PCA model which uses 
%only one pointer.