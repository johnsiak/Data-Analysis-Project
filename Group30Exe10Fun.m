%Ioannis Siakavaras
%Christoforos Chatziantoniou

function [opt_model, opt_lambda] =  Group30Exe10Fun(y, X)

    %find the rows with observations for all indicators
    nanRows = isnan(X);
    y(any(nanRows,2),:) = []; 
    X(any(nanRows,2),:) = []; 
    
    %calculating the adjusted R-squared for all possible models
    max_adj_r_squared = -inf;
    for i = 1:size(X, 2)
        models = nchoosek(1:size(X, 2), i);
        for j = 1:size(models, 1)
            model = models(j, :);
            lm = fitlm(X(:, model), y);
            adj_r_squared = lm.Rsquared.Adjusted;
            if adj_r_squared > max_adj_r_squared
                max_adj_r_squared = adj_r_squared;
                opt_model = model;
            end
        end
    end
    
    %LASSO method to the best model found
    opt_lambda = NaN;
    max_adj_r_squared = -inf;
    for lambda = linspace(0, max(max(X(:, opt_model))), 100)
        lasso_model = lasso(X(:, opt_model), y, 'Lambda', lambda);
        adj_r_squared = 1 - (sum((y - X(:, opt_model) * lasso_model).^2)/(length(y) - size(X(:, opt_model), 2) - 1));
        if adj_r_squared > max_adj_r_squared
            max_adj_r_squared = adj_r_squared;
            opt_lambda = lambda;
        end
    end
    
    %if lasso method fails to detect the optimal model we return lambda = NaN
    if lasso_model ~= opt_model
        opt_lambda = NaN;
    end
end