function [p1, p2, cont] = Group30Exe1Fun(x)
    if(length(unique(x)) > 10) %number of different values in vector x
        cont = 1; %continuous
        [~, p1] = chi2gof(x); %normal dist
        uni = makedist("Uniform", min(x), max(x)); %uniform dist
        [~, p2] = chi2gof(x,"CDF",uni);
        figure();
        histogram(x);
        ourTitle=sprintf("p1 = %d, p2 = %d", p1, p2);
        title(ourTitle);

    else
        cont = 0; %discrete
        binom = makedist("Binomial", length(x), (1/length(x))); %binomial dist, n = length(x), p = 1/n
        [~, p1] = chi2gof(x,"CDF",binom);
        unid = makedist("Uniform", min(x), max(x)); %uniform dist
        [~, p2] = chi2gof(x,"CDF",unid);
        figure();
        bar(x); %bar chart
        ourTitle=sprintf("p1 = %d, p2 = %d", p1, p2);
        title(ourTitle);
    end
end
