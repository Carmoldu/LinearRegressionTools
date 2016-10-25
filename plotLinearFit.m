function [h] = plotLinearFit( x, y, b, graph, Title, xAxis,yAxis)
%Plots the data of a data set and its linear fit
%INPUTS:
% -x: x values
% -y: y values
% -b: linear regression parameters [beta0; beta1]
% -graph (optional): if wanted, enter the number of the figure you want it
% to be ploted, else it will plot on figure(1)
% -Title (optional): string with the title of the graph
% -xAxis (optional): string with the x axis label
% -yAxis (optional): string with the y axis label
%
%OUTPUT:
% -h: figure handle
%
%By: Carles Molins Duran

if nargin < 2
   graph = 1;
end
if nargin < 3
   Title = 'n';
end
if nargin < 4
   xAxis = 'n';
end
if nargin < 5
   yAxis = 'n';
end

X = [ones(length(x),1),x];
yCalc = X*b;

h=figure(graph);

scatter(x,y)
hold on
plot(x,yCalc)
    
    if ~strcmp(xAxis,'n')
        xlabel(xAxis)
    end
    if ~strcmp(yAxis,'n')
        ylabel(yAxis)
    end
    if ~strcmp(Title,'n')
        title(Title)
    end

grid on

end

