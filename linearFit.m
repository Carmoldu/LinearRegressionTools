function [ b, Rsq, theta2, deltaBeta0, deltaBeta1, h ] = linearFit( x, y, graph, Title, xAxis, yAxis, display, report )
%Returns the least sqares linear fit (Y=beta0+beta1*X) parameters beta0
%and beta1, as well as the R2 value of the fit.
%INPUTS:
% -x: x values
% -y: y values
% -graph (optional): if wanted, enter the number of the figure you want it to be ploted, if not wanted, just don't fill it
% -Title (optional): string with the title of the graph
% -xAxis (optional): string with the x axis label
% -yAxis (optional): string with the y axis label
% -Display (optional): 'y'/'n', if 'y' it will print the results of the
%                   lineal fit at the command window.
% -Report (optional): if filled with a string, it will create (or open if it already exists) a file where it will print the results.
%
%
%OUTPUTS:
% -b: linear regression parameters [beta0; beta1]
% -Rsq: quadratic error of the linear regression
% -theta2: variance of the linear regression
% -deltaBeta0: Confidence level on beta0
% -deltaBeta1: Confidence level on beta1
% -h: figure handle of the plot.
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
if nargin < 7
   display = 'n';
end
if nargin < 8
   report = 'n';
end


%%
%Computation of the parameters

%Precalculations
n=length(x);

xMean=sum(x)/n;
yMean=sum(y)/n;

Sxx=sum((x-xMean).^2);
Syy=sum((y-yMean).^2);
Sxy=sum((x-xMean).*(y-yMean));

%Parameter computation
beta1=Sxy/Sxx;
beta0=yMean-beta1*xMean;

b=[beta0;beta1];
X = [ones(length(x),1),x];
yCalc = X*b;

%R2 computation
Rsq = 1 - sum((y - yCalc).^2)/sum((y - yMean).^2);

%Variance computation
theta2=(Syy-beta1*Sxy)/(n-2);

VarBeta0=theta2*(1/n+xMean^2/Sxx);
VarBeta1=theta2*(1/Sxx);

%Confidence levels for 95% confidence
deltaBeta0=tn_2(n)*sqrt(VarBeta0);
deltaBeta1=tn_2(n)*sqrt(VarBeta1);

%%
%Plot

if ~strcmp(graph,'n')
    [h] = plotLinearFit( x, y, b, graph, Title, xAxis,yAxis);    
end

%%
%Display of results on screen
if strcmp(display,'y')
    if strcmp(Title,'')
        Title=0;
    end
    if strcmp(xAxis,'n')
        xAxis='x';
    end
    if strcmp(yAxis,'n')
        yAxis='x';
    end
    
    firstline = 'Linear Fit "%s":\n';
    secondline =  '\t %s = %.3f +-%.3f + (%.3f +-%.3f)*%s\n';
    thirdline = '\t R^2=%.3f \t Variance=%.3f\n\n';
    FormatSpec=strcat(firstline,secondline,thirdline);
    
    fprintf(FormatSpec,Title,yAxis,b(1),deltaBeta0,b(2),deltaBeta1,xAxis,Rsq,theta2)     
    
end

%%
%Report
if ~strcmp(report,'n')
    if strcmp(Title,'n')
        Title='';
    end
    if strcmp(xAxis,'n')
        xAxis='x';
    end
    if strcmp(yAxis,'n')
        yAxis='x';
    end
    
    firstline = 'Linear Fit "%s":\n';
    secondline =  '\t %s = %.3f +-%.3f + (%.3f +-%.3f)*%s\n';
    thirdline = '\t R^2=%.3f \t Variance=%.3f\n\n';
    FormatSpec=strcat(firstline,secondline,thirdline);
    
    file=fopen(report,'a+t');
    fprintf(file,FormatSpec,Title,yAxis,b(1),deltaBeta0,b(2),deltaBeta1,xAxis,Rsq,theta2); 
    fclose(file);
    
end
end

