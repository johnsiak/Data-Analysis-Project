clear all
clc

Ta = readmatrix('Heathrow.xlsx');
Ta(:,11) = []; %removing TN

rsq = zeros(10);

for i=2:11
    figure; %we create a figure for each pointer
    for j=2:11
        if(i==j) 
            continue %we don't want to check one pointer with itself
        end
        rsq(i-1,j-1) = Group30Exe6Fun(Ta(:,j), Ta(:,i));
        hold on
    end
end

max_index = zeros(10,2);

%we find the 2 max values in each row and store the index
for i=1:10
    [~, max_index(i,:)] = maxk(rsq(i,:), 2);
end

indication = ["T" "TM" "Tm" "PP" "V" "RA" "SN" "TS" "FG" "GR"];

array = strings(10,3);

%array with the best 2 pointers for each Y
for i=1:10
    array(i,1) = sprintf("Y = %s", indication(i));
    array(i,2) = sprintf("X1 = %s", indication(max_index(i,1)));
    array(i,3) = sprintf("X2 = %s", indication(max_index(i,2)));

end

display(array);

%we can see that r^2 is greater than 0.8 only once, for T and TM
%therefore we can predict T from TM and vice-versa with high accuracy
