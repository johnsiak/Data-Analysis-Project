%Ioannis Siakavaras
%Christoforos Chatziantoniou

clear all
clc

Ta = readmatrix('Heathrow.xlsx');

%I have to seperate them and save them in different variables because 
%after I remove the NaN values all the columns won't have the same number
%of rows.
T = Ta(:,2);
TM = Ta(:,3);
Tm = Ta(:,4);
PP = Ta(:,5);
V = Ta(:,6);
RA = Ta(:,7);
SN = Ta(:,8);
TS = Ta(:,9);
FG = Ta(:,10);
TN = Ta(:,11);
GR = Ta(:,12);

%remove NaN from each column
T = T(~isnan(T))'; 
TM = TM(~isnan(TM))';
Tm = Tm(~isnan(Tm))';
PP = PP(~isnan(PP))';
V = V(~isnan(V))';
RA = RA(~isnan(RA))';
SN = SN(~isnan(SN))';
TS = TS(~isnan(TS))';
FG = FG(~isnan(FG))';
TN = TN(~isnan(TN))';
GR = GR(~isnan(GR))';

p1 = zeros(1, width(Ta)-1);
p2 = zeros(1, width(Ta)-1);
cont = zeros(1, width(Ta)-1);

pointers = ["T" "TM" "Tm" "PP" "V" "RA" "SN" "TS" "FG" "TN" "GR"];
indicator = ["Normal Distribution" "Uniform Distribution" "Binomial Distribution" "Discrete Uniform Distribution"];
dist = strings(1,width(Ta)-1);

[p1(1), p2(1), cont(1)] = Group30Exe1Fun(T);
[p1(2), p2(2), cont(2)] = Group30Exe1Fun(TM);
[p1(3), p2(3), cont(3)] = Group30Exe1Fun(Tm);
[p1(4), p2(4), cont(4)] = Group30Exe1Fun(PP);
[p1(5), p2(5), cont(5)] = Group30Exe1Fun(V);
[p1(6), p2(6), cont(6)] = Group30Exe1Fun(RA);
[p1(7), p2(7), cont(7)] = Group30Exe1Fun(SN);
[p1(8), p2(8), cont(8)] = Group30Exe1Fun(TS);
[p1(9), p2(9), cont(9)] = Group30Exe1Fun(FG);
[p1(10), p2(10), cont(10)] = Group30Exe1Fun(TN);
[p1(11), p2(11), cont(11)] = Group30Exe1Fun(GR);


for i=1:length(p1)
    
    %both p values are over 0.05
    if(p1(i) > 0.05 && p2(i) > 0.05) 
        if(p1(i) > p2(i)) 
            if cont(i)
                dist(i) = indicator(1); %normal distribution
            else
                dist(i) = indicator(3); %binomial distribution
            end
        else
            if cont(i)
                dist(i) = indicator(2); %uniform distribution
            else
                dist(i) = indicator(4); %discrete uniform distribution
            end
        end    
    
    %one p value is over 0.05
    elseif(p1(i) > 0.05)
            if cont(i)
                dist(i) = indicator(1); %normal distribution
            else
                dist(i) = indicator(3); %binomial distribution
            end

    %one p value is over 0.05        
    elseif(p2(i) > 0.05)
            if cont(i)
                dist(i) = indicator(2); %uniform distribution
            else
                dist(i) = indicator(4); %discrete uniform distribution
            end

    %none of the p values is over 0.05
    else
        dist(i) = "Unable to fit to given distributions"; 
    end
end

array = strings(11,4);

for i=1:11
    array(i,1) = pointers(i);
    array(i,2) = p1(i);
    array(i,3) = p2(i);
    array(i,4) = dist(i);
end

display(array);

%we can see that T and TM are best fitted into a uniform distribution
%PP, V, RA and TS are best fitted into a normal distribution
%and the rest of the pointers are not fitted into any given distribution.