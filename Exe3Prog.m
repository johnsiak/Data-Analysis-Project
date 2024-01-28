clear all
clc

Ta = readmatrix('Heathrow.xlsx');

%PP has no values in the years 1949-1958 so we remove it
%erasing indexes 4, 10, 11
Ta(:,12) = [];
Ta(:,11) = [];
Ta(:,5) = [];

p1 = zeros(1,8);
p2 = zeros(1,8);

for i = 2:9
    [p1(i-1), p2(i-1)] = Group30Exe3Fun(Ta(:,1), Ta(:,i)); %the first argument is the year column
end

disp(p1);
disp(p2);

%The p values from ttest2 are not reliable because we assume that the 2
%sub-samples (1949-1958 and 1973-2017) are indpependent and come from a 
%normal distribution and their variances are equal. 
%The assumptions are not met.

%we also use the randomization method and not the bootstrap method because
%the first subsample from each pointer is small (only 10 values)
%the randomization method is prefered in this case.

%The 2 methods do not generally agree as the parametrical test is not
%always reliable. 

%The samples where the 2 means are statistically different are V and FG as
%the p values from the randomization method are very close to 0.
%Coincidentally, the parametrical p values in those pointers are both very
%close to 0 as well.
