function [ out ] = tn_2( n )
%Returns the multiplier to compute the confidence level on the
%coefficients for 95% confidence, which depends on the number of data points.
%Input:
% -n: number of data points
%
%Output:
% -Out: Extrapolated value from the tabulated values
%
%By: Carles Molins Duran

x=n-2;

table=[10   2.228
       11   2.201
       12   2.179
       13   2.16
       14   2.145
       15   2.131
       16   2.120
       17   2.110
       18   2.101
       19   2.093
       20   2.086
       22   2.074
       24   2.064
       26   2.056
       30   2.042
       40   2.021
       60   2
       120  1.98];


if x<10
    error('Not enough data points!')
elseif    x>120
    out=1.96;
else
    out=interp1(table(:,1),table(:,2),n);
end

end

