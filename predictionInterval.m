function [ ymin,ymax,deltaY ] = predictionInterval(  b, x, theta2, val, display)
%Returns the prediction interval of a data series for a given value
%
%INPUTS
% -b: linear regression parameters [b0; b1]
% -x: x values of the series
% -theta2: variance
% -mode: if you want to find the extrapolated value corresponding to a x
%        value, type 'givenXvalue', if you want to find the extrapolated value
%        corresponding to x=0 value type 'findY', you want to find the extrapolated value
%        corresponding to y=0 value type 'findX'
% -Val: value for which you want to evaluate the prediction interval.
% -Display (optional): 'y'/'n', if 'y' it will print the results of the
%                   prediction interval at the command window.
%
%OUTPUTS:
% -ymin: minimum value of the prediction interval at x=val
% -ymax: maximum value of the prediction interval at x=val
% -deltaY: abs(ymin-ymax)
%
%By: Carles Molins Duran

if nargin < 5
   display = 'n';
end

n=length(x);

xMean=sum(x)/n;
Sxx=sum((x-xMean).^2);

deltaY=tn_2(n)*sqrt(theta2*(1+1/n+(val-xMean)^2/Sxx));

ymin=b(1)+b(2)*val-deltaY;
ymax=b(1)+b(2)*val+deltaY;


if strcmp(display,'y')  
    firstline = 'Prediction interval:\n';
    secondline =  '\t Query point: X=%.3f\t Y=%.3f\n\tYmin=%.3f\t Ymax=%.3f\n\n';

    FormatSpec=strcat(firstline,secondline);
    
    fprintf(FormatSpec,val, b(1)+b(2)*val, ymin, ymax)     
    
end

end
