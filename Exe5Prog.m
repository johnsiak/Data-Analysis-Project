clear all
clc

Ta = readmatrix('Heathrow.xlsx');

TM = Ta(:,3);
RA = Ta(:,7);
SN = Ta(:,8);
TS = Ta(:,9);

%removing NaN values
not_nan2 = ~isnan(TM) & ~isnan(RA);
TM = TM(not_nan2);
RA = RA(not_nan2);

not_nan2 = ~isnan(SN) & ~isnan(TS);
SN = SN(not_nan2);
TS = TS(not_nan2);

%pearson correlation coefficient and p-value
[r1, p1] = corr(TM, RA);
[r2, p2] = corr(SN, TS);

%mutual information
[I1, p_I1, len1] = Group30Exe5Fun2(TM, RA);
[I2, p_I2, len2] = Group30Exe5Fun2(SN, TS);

fprintf("Pearson correlation coefficient:\n");
fprintf("TM - RA: r = %f, p = %f\n", r1, p1);
fprintf("SN - TS: r = %f, p = %f\n\n", r2, p2);

fprintf("Results from mutual information:\n");
fprintf("TM - RA: I = %f, p = %f, length = %d\n", I1, p_I1, len1);
fprintf("SN - TS: I = %f, p = %f, length = %d\n", I2, p_I2, len2);

%in exercise 6 we can see that TM - RA and SN - TS have the lowest r^2 
%so we choose these sets of pointers for this exercise.

%we can see that the pearson correlation coefficients are very low 0.0018
%and 0.0093 and the p values are very high 0.989 and 0.946 so we can say 
%with very high accuracy that both sets of pointers are not linearly correlated.

%the results of the mutual information using the entropies method is also
%pretty much the same as the mutual information is very low and the p
%values are relatively high, not as high as they are using the pearson
%method, so it should be noted that the pearson method is more reliable.

%all in all, the pearson method tells us they are not linearly correlated.
%the mutual information gives us a general picture about their correlation,
%as it captures both linear and nonlinear relationships. so we can say with
%certainty that these 2 sets of pointers are not correlated
