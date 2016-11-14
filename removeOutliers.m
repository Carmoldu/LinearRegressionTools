function [ xNew, yNew, inMargins ,b] = removeOutliers( x, y, graph, Title, xAxis, yAxis )
%Removes the outliers that are out of the 95% confidence level
%
%[ xNew, yNew, inMargins ,b] = removeOutliers( x, y, graph, Title, xAxis, yAxis )
%INPUTS:
% -x: x values
% -y: y values
% -graph (optional): if wanted, enter the number of the figure you want it to be ploted, if not wanted, just don't fill it
% -Title (optional): string with the title of the graph
% -xAxis (optional): string with the x axis label
% -yAxis (optional): string with the y axis label
%
%OUTPUTS:
% -xNew: new vector with the x values that are inside of the 95%confidence
%       margin
% -yNew: corresponding y values to xNew
% -inMargins: boolean vector with the same length as x and y. If the value
%             of a row is 1 it means that the corresponding row in x and y was inside
%             the 95%confidence margins
% -b: value of the linear regression parameter before removing the
%     outliers.
%
%By: Carles Molins Duran

%%
%Argument management

if nargin < 3
   graph = 'n';
end
if nargin < 4
   Title = 'n';
end
if nargin < 5
   xAxis = 'n';
end
if nargin < 6
   yAxis = 'n';
end

%%

[  b, ~, theta2, ~, ~, ~ ] = linearFit( x, y, graph, Title, xAxis, yAxis);

residuals=y-b(1)-b(2)*x;
standResiduals=residuals/sqrt(theta2);
refConfidence=tn_2(length(x));

inMargins = abs(standResiduals)<refConfidence;

xNew=x(inMargins);
yNew=y(inMargins);
%%
%Plot

if graph~='n'
        
   xErrased =x(~inMargins);
   yErrased =y(~inMargins); 
   
   scatter(xErrased,yErrased,'r','x')
    
   X = [ones(length(x),1),x];
   yUpper = X*b+refConfidence*sqrt(theta2);
   yLower = X*b-refConfidence*sqrt(theta2);
   plot(x,yUpper,'.r')
   plot(x,yLower,'.r')
   
   
end
end

