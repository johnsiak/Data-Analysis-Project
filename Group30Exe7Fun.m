%Ioannis Siakavaras
%Christoforos Chatziantoniou

function [model, adjRsquare] = Group30Exe7Fun(x, y)
    
    %removing NaN values
    not_nan = ~isnan(x) & ~isnan(y);
    x = x(not_nan);
    y = y(not_nan);

    Rsq = zeros(1,6);
    adjRsq = zeros(1,6);
    
    %functions for R-square and adjR-square based on theory
    R2 = @(yfit, y) 1 - sum((yfit-y).^2)/sum((y - mean(y)).^2); 
    adjR2 = @(yfit, y, n, j) (1 - (n-1)/(n-1-j)*sum((yfit-y).^2)/sum((y-mean(y)).^2));

    for i=1:3
        b = polyfit(x,y,i); %the default method of polyfit is the least squares method
        yfit = polyval(b,x);
        
        Rsq(i) = R2(yfit,y);
        adjRsq(i) = adjR2(yfit, y, length(y), i);
        
        %scatter plot and the estimated curves in the subplot
        subplot(2,3,i);
        scatter(x,y);
        hold on;
        plot(x,yfit);
        hold on;
        ourTitle = sprintf("polynomial regression for k = %d", i);
        title(ourTitle);
        ourText = sprintf("adjR^2 = %d", adjRsq(i));
        text(x(1),y(1), ourText); %the coordinates of the text are random

    end
    
    %removing 0 values because ln(0) is negative infinity
    not_zero = x ~=0 & y ~= 0;
    x = x(not_zero);
    y = y(not_zero);

    
    %y' = ln(y)
    y1 = log(y);
    X1 = [ones(size(x)), x];
    b1 = X1\y1; %least squares method
    Rsq(4) = 1 - sum((y1-X1*b1).^2)/sum((y1-mean(y1)).^2); %r^2
    adjRsq(4) = 1 - ((1 - Rsq(4))*(length(y1) - 1)/(length(y1) - 1 - 1)); %p = 1 because we have one independent variable
    
    %scatter plot and the estimated curve in the subplot
    subplot(2,3,4);
    scatter(x,y1);
    hold on;
    xl1 = linspace(min(x), max(x));
    
    yl1 = b1(1) + b1(2)*xl1;
    plot(xl1, yl1);
    xlabel('x');
    ylabel('y');
    title("Intrinsically Linear Method 1");
    ourText1 = sprintf("adjR^2 = %d", adjRsq(4));
    text(x(1),y1(1), ourText1);

    %y' = ln(y)
    %x' = ln(x)
    y2 = log(y);
    x2 = log(x);
    X2 = [ones(size(x2)), x2];
    b2 = X2\y2;
    Rsq(5) = 1 - sum((y2-X2*b2).^2)/sum((y2-mean(y2)).^2);
    adjRsq(5) = 1 - ((1 - Rsq(5))*(length(y2) - 1)/(length(y2) - 1 - 1));
    
    %scatter plot and the estimated curve in the subplot
    subplot(2,3,5);
    scatter(x2,y2);
    hold on;
    xl2 = linspace(min(x2), max(x2));
    
    yl2 = b2(1) + b2(2)*xl2;
    plot(xl2, yl2);
    xlabel('x');
    ylabel('y');
    title("Intrinsically Linear Method 2");
    ourText2 = sprintf("adjR^2 = %d", adjRsq(5));
    text(x2(5),y2(1), ourText2);

    %x' = 1/x
    x3 = 1./x;
    X3 = [ones(size(x3)), x3];
    b3 = X3\y;
    Rsq(6) = 1 - sum((y-X3*b3).^2)/sum((y-mean(y)).^2);
    adjRsq(6) = 1 - ((1 - Rsq(6))*(length(y) - 1)/(length(y) - 1 - 1));
    
    %scatter plot and the estimated curve in the subplot
    subplot(2,3,6);
    scatter(x3,y);
    hold on;
    xl3 = linspace(min(x3), max(x3));
    
    yl3 = b3(1) + b3(2)*xl3;
    plot(xl3, yl3);
    xlabel('x');
    ylabel('y');
    title("Intrinsically Linear Method 4");
    ourText3 = sprintf("adjR^2 = %d", adjRsq(6));
    text(x3(1),y(1), ourText3);
    
    %we choose the best model based on the maximun adj-R^2
    %model is 1-6 depending on the index of the the maximum adj-R^2
    [adjRsquare, model] = max(adjRsq);
end