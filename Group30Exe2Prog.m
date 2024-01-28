%Ioannis Siakavaras
%Christoforos Chatziantoniou

clear all;
clc;

Ta = readmatrix('Heathrow.xlsx');

%we get each index as a matrix with one column
T = Ta(:,2);
TM = Ta(:,3);
Tm = Ta(:,4);
PP = Ta(:,5);
V = Ta(:,6);
RA = Ta(:,7);
SN = Ta(:,8);
TS = Ta(:,9);
FG = Ta(:,10);

%seperation of each matrix in two matrices: 1949-58 and 1973-2017
T_1 = T(1:10);
T_2 = T(11:55);
TM_1 = TM(1:10);
TM_2 = TM(11:55);
Tm_1 = Tm(1:10);
Tm_2 = Tm(11:55);
PP_1 = PP(1:10);
PP_2 = PP(11:55);
V_1 = V(1:10);
V_2 = V(11:55);
RA_1 = RA(1:10);
RA_2 = RA(11:55);
SN_1 = SN(1:10);
SN_2 = SN(11:55);
TS_1 = TS(1:10);
TS_2 = TS(11:55);
FG_1 = FG(1:10);
FG_2 = FG(11:55);

%erase empty places
T_1 = T_1(~isnan(T_1))'; 
TM_1 = TM_1(~isnan(TM_1))';
Tm_1 = Tm_1(~isnan(Tm_1))';
PP_1 = PP_1(~isnan(PP_1))';
V_1 = V_1(~isnan(V_1))';
RA_1 = RA_1(~isnan(RA_1))';
SN_1 = SN_1(~isnan(SN_1))';
TS_1 = TS_1(~isnan(TS_1))';
FG_1 = FG_1(~isnan(FG_1))';

T_2 = T_2(~isnan(T_2))'; 
TM_2 = TM_2(~isnan(TM_2))';
Tm_2 = Tm_2(~isnan(Tm_2))';
PP_2 = PP_2(~isnan(PP_2))';
V_2 = V_2(~isnan(V_2))';
RA_2 = RA_2(~isnan(RA_2))';
SN_2 = SN_2(~isnan(SN_2))';
TS_2 = TS_2(~isnan(TS_2))';
FG_2 = FG_2(~isnan(FG_2))';

%matrices that store the confidence interval for each case
ci_p = zeros(2, 9);
ci_b = zeros(2, 9);

[ci_p(:,1), ci_b(:,1)] = Group30Exe2Fun(T_2);
[ci_p(:,2), ci_b(:,2)] = Group30Exe2Fun(TM_2);
[ci_p(:,3), ci_b(:,3)] = Group30Exe2Fun(Tm_2);
[ci_p(:,4), ci_b(:,4)] = Group30Exe2Fun(PP_2);
[ci_p(:,5), ci_b(:,5)] = Group30Exe2Fun(V_2);
[ci_p(:,6), ci_b(:,6)] = Group30Exe2Fun(RA_2);
[ci_p(:,7), ci_b(:,7)] = Group30Exe2Fun(SN_2);
[ci_p(:,8), ci_b(:,8)] = Group30Exe2Fun(TS_2);
[ci_p(:,9), ci_b(:,9)] = Group30Exe2Fun(FG_2);

%matrix that stores the mean values for each case
means = zeros(1, 9);

means(1) = mean(T_1);
means(2) = mean(TM_1);
means(3) = mean(Tm_1);
means(4) = mean(PP_1);
means(5) = mean(V_1);
means(6) = mean(RA_1);
means(7) = mean(SN_1);
means(8) = mean(TS_1);
means(9) = mean(FG_1);

%check if mean value in 1949-58 belongs to the confidence intervals of
%1973-2017 and print proper message
for i = 1:9
    if ((means(i) > ci_p(1,i)) && (means(i) < ci_p(2,i))) 
        fprintf("Mean of Index %d belongs to Parametric Confidence Interval\n", i);
    else 
        fprintf("Mean of Index %d does not belong to Parametric Confidence Interval\n", i);
    end
    if ((means(i) > ci_b(1,i)) && (means(i) < ci_b(2,i)))
        fprintf("Mean of Index %d belongs to Bootstrap Confidence Interval\n", i);
    else 
        fprintf("Mean of Index %d does not belong to Bootstrap Confidence Interval\n", i);
    end
end

%We can see that the parametric and bootstrap confidence intervals are
%similar to each other for every index
%By the check above we noticed that the mean values of Tm and SN indexes do not change from
%1949-58 to 1973-2017 but the others do