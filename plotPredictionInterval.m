function [  ] = plotPredictionInterval( b, x, theta2, xmin,xmax, Fig)
%Plots on figure 'Fig' the prediction interval of the range comprised between
%xmin and xmax.
%
%plotPredictionInterval( b, x, theta2, xmin,xmax, Fig)
%INPUTS:
% -b: linear regression parameters [b0; b1]
% -x: x values of the series
% -theta2: variance
% -xmin: minimum X value of the range
% -xmax: maximum X value of the range
% -Fig: figure where the curves are to be ploted
%
% OUTPUT
% -plot of the prediction interval over the specified range
%
%By: Carles Molins Duran

xVal=linspace(xmin,xmax,100);


for i=1:length(xVal)
    [ minimum(i),maximum(i),~ ] = predictionInterval(  b, x, theta2, xVal(i));
end


figure(Fig)

plot(xVal,maximum,'-.k')
plot(xVal,minimum,'-.k')
end

