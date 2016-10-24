function [ ] = plotExtrapolation( b, x, theta2, xmin, xmax, Fig )
%plots the curves of the certainity of an extrapolation over a range.
%
%INPUTS:
% -b: linear regression parameters [b0; b1]
% -x: x values of the series
% -theta2: variance
% -xmin: minimum X value of the range
% -xmax: maximum X value of the range
% -Fig: figure where the curves are to be ploted
%
%OUTPUT:
% -Plot of the extrapolation in the given range.
%
%By: Carles Molins Duran


xVal=linspace(xmin,xmax,100);

for i=1:length(xVal)
[ extrapolatedValue(i), maximum(i), minimum(i)] = extrapolate( b, x, theta2, 'givenXvalue', xVal(i));
end

figure(Fig)

plot(xVal,extrapolatedValue,'g')
plot(xVal,maximum,'.g')
plot(xVal,minimum,'.g')


end

