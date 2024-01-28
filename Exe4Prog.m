clear all
clc

Ta = readmatrix('Heathrow.xlsx');

%erase indexes 10, 11 and the year column 
Ta(:,12) = [];
Ta(:,11) = [];
Ta(:,1) = [];

%initialization of lists that store the correlated pairs of indexes in
%each case
myList_1 = zeros(2, 36); %parametric ci
myList_2 = zeros(2, 36); %non-parametric ci
myList_3 = zeros(3, 36); %parametric test, one extra line for p value
myList_4 = zeros(3, 36); %non-parametric test, one extra line for p value

k = 1;

%run the function for all possible pairs and check correlation
for i = 1:9
    for j = i:8
        [a, b, c, d, e] = Group30Exe4Fun(Ta(:, i), Ta(:, j+1));
        if (a(1)*a(2) > 0) %the ci does not contain 0
            myList_1(:, k) = [i, j+1];
        end
        if (b(1)*b(2) > 0) 
            myList_2(:, k) = [i, j+1];
        end
        if (c < 0.05) %p value < 0.05 means hypothesis for zero correlation can be rejected
            myList_3(1:2, k) = [i, j+1];
            myList_3(3, k) = c;
        end
        if (d < 0.05) 
            myList_4(1:2, k) = [i, j+1];
            myList_4(3, k) = d;
        end
        k = k+1;
    end
end

%erase zero values
myList_1(:,all(myList_1==0)) = []; 
myList_2(:,all(myList_2==0)) = [];
myList_3(:,all(myList_3==0)) = [];
myList_4(:,all(myList_4==0)) = [];

%We can see through the parametric ci (Fisher transformation), the parametric
%test and the non-parametric test (randomization method),that the correlated
%pairs are the same, and also the bootstrap ci almost agree with these methods
%The two test methods agree that the pairs with the most statistically
%significant correltaion are: (1,2) , (1,7) , (2,7) , (6,9)
