%Ioannis Siakavaras
%Christoforos Chatziantoniou

clear all
clc

Ta = readmatrix('Heathrow.xlsx');

FG = Ta(:,10);
GR = Ta(:,12);

Ta(:,12) = [];
Ta(:,11) = []; 
Ta(:,10) = []; 
Ta(:,1) = [];

[mdl_fg, l_fg] = Group30Exe10Fun(FG, Ta);
[mdl_gr, l_gr] = Group30Exe10Fun(GR, Ta);

%the optimal model found based on the highest adjusted-r^2 is returned by
%the function. we apply the lasso model and in both cases it fails to
%detect the optimal model as all of the predictors are shrunk to zero
%by the LASSO penalty.
%therefore, the optimal lambda does not exist so lambda = NaN