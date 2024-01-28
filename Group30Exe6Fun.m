%Ioannis Siakavaras
%Christoforos Chatziantoniou

function [rsq] = Group30Exe6Fun(x, y)

    %removing NaN values
    not_nan = ~isnan(x) & ~isnan(y);
    x = x(not_nan);
    y = y(not_nan);

    
    X = [ones(size(x)), x];
    b = X\y; %least squares method
    rsq = 1 - sum((y-X*b).^2)/sum((y-mean(y)).^2); %r^2
    
    %scatter plot and the estimated line
    scatter(x,y);
    hold on;

    x1 = linspace(min(x), max(x));
    y1 = b(1) + b(2)*x1;
    plot(x1, y1);

    xlabel('x');
    ylabel('y');
    ourText=sprintf("R^2 = %d", rsq);
    text(x(1),y(2), ourText); %the coordinates of the text are random
end