%Ioannis Siakavaras
%Christoforos Chatziantoniou

clear all
clc

Ta = readmatrix('Heathrow.xlsx');
FG = Ta(:,10);

Ta(:,11) = []; %removing TN
Ta(:,10) = []; %removing FG

model = zeros(1,9);
adjRsq = zeros(1,9);

for i=2:10
    figure %we create a new figure for each pointer
    [model(i - 1), adjRsq(i - 1)] = Group30Exe7Fun(Ta(:,i), FG);
end

[~, best_pointer] = maxk(adjRsq, 2);
best_model = model(best_pointer);

disp("best pointers = " + best_pointer);
disp("best models = " + best_model);

%We can see that FG is described best by RA (6th pointer)
%Its adjR^2 value is still not adequate as it's only 0.349
%The best model is the 2nd model (out of 6) which is a 2nd degree polynomial.
%The second best pointer is T (1st pointer) which has an adjR^2 value of
%0.2538 and the best model is the 5th model which uses the y' = ln(y) and 
%x' = ln(x) transformations.