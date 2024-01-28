clear all
clc

Ta = readmatrix('Heathrow.xlsx');
FG = Ta(:,10);

% erase FG and TN column
Ta(:,11) = []; 
Ta(:,10) = []; 

adjRsq = zeros(1, 9);
p_value = zeros(1, 9);

%find adjRsq and p_value for each case
for i = 2:10
    [adjRsq(i-1), p_value(i-1)] = Group30Exe8Fun(Ta(:,i), FG);
end

%We noticed that the pointers that explain FG pointer the best are: 
%T, TM, Tm, V, RA
