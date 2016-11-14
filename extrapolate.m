function [ extrapolatedValue, maximum, minimum] = extrapolate( b, x, theta2, mode, val, display, report)
%This function will give you the extrapolated value following the linear
%regression of a dataset as well as its uncertainity values.
%[ extrapolatedValue, maximum, minimum] = extrapolate( b, x, theta2, mode, val, display, report)
%
%INPUTS
% -b: linear regression parameters [b0; b1]
% -x: x values of the series
% -theta2: variance
% -mode: if you want to find the extrapolated value corresponding to a x
%        value, type 'givenXvalue';  if you want to find the extrapolated value
%        of X corresponding to y=0 type 'findX'
% -Val: value you want to extrapolate. If in 'givenXvalue' mode it is not
%         entered, it will be computed for x=0. Enter any number in 'findX'
%         mode , it will always compute for Y=0
% -Display (optional): 'y'/'n', if 'y' it will print the results of the
%                   lineal fit at the command window.
% -Report (optional): if filled with a string, it will create (or open if
%                     it already exists) a file where it will print the results. Remember to
%                     add .txt at the end of the name.
%
%OUTPUTS:
% -%extrapolatedValue: Value obtained from following the linear regression
%           up to the evaluation point given.
% -maximum: maximum uncertainity value
% -minimum: minimum uncertainity value
%
%By: Carles Molins Duran


if nargin<5
    val=0;
end
if nargin < 6
   display = 'n';
end
if nargin < 7
   report = 'n';
end

n=length(x);

xMean=sum(x)/n;
Sxx=sum((x-xMean).^2);

if strcmp('givenXvalue',mode)
    extrapolatedValue=b(1)+b(2)*val;

    confidence=tn_2(n)*sqrt(theta2*(1/n+(val-xMean)^2/Sxx));

    maximum=extrapolatedValue+confidence;
    minimum=extrapolatedValue-confidence;


elseif strcmp('findX',mode)
    val=0;
    extrapolatedValue=-b(1)/b(2);


    iter=0;
    error=100;
    maximum=extrapolatedValue;


    while iter<100 && error>10^-(6)
        maximumAux = -b(1)/b(2)+tn_2(n)/b(2)*sqrt(theta2*(1/n+(maximum-xMean)^2/Sxx));

        error=abs(maximum-maximumAux);
        maximum=maximumAux;
    end


    iter=0;
    error=100;
    minimum=extrapolatedValue;


    while iter<100 && error>10^-(6)
        minimumAux = -b(1)/b(2)-tn_2(n)/b(2)*sqrt(theta2*(1/n+(minimum-xMean)^2/Sxx));

        error=abs(minimum-minimumAux);
        minimum=minimumAux;
    end
    
    confidence=abs(maximum-minimum);

end


%%
%Display
if strcmp(display,'y')  
    
    firstline = 'Extrapolated value: (mode: %s)\n';
    
    if strcmp('givenXvalue',mode)
        secondline =  '\t Query point: X=%.3f\n\t Extrapolated Value: Y=%.3f +-%.3f\n\n';
    end
    if strcmp('findX',mode)
        secondline =  '\t Query point: Y=%i\n\t Extrapolated Value: X=%.3f +-%.3f\n\n';
    end
    
    FormatSpec=strcat(firstline,secondline);
    
    fprintf(FormatSpec,mode,val,extrapolatedValue, confidence)     
    
end

%%
%report
if ~strcmp(report,'n')  
    
    firstline = 'Extrapolated value: (mode: %s)\n';
    
    if strcmp('givenXvalue',mode)
        secondline =  '\t Query point: X=%.3f\n\t Extrapolated Value: Y=%.3f +-%.3f\n\n';
    end
    if strcmp('findX',mode)
        secondline =  '\t Query point: Y=%i\n\t Extrapolated Value: X=%.3f +-%.3f\n\n';
    end
    
    FormatSpec=strcat(firstline,secondline);
    
    file=fopen(report,'a+t');
    fprintf(file, FormatSpec,mode,val,extrapolatedValue, confidence);   
    fclose(file);
    
end
end

