function [ extrapolatedValue, maximum, minimum] = extrapolate( b, x, theta2, mode, val)
%This function will give you the extrapolated value following the linear
%regression of a dataset as well as its uncertainity values.
%
%INPUTS
% -b: linear regression parameters [b0; b1]
% -x: x values of the series
% -theta2: variance
% -mode: if you want to find the extrapolated value corresponding to a x
%        value, type 'givenXvalue', if you want to find the extrapolated value
%        corresponding to x=0 value type 'findY', you want to find the extrapolated value
%        corresponding to y=0 value type 'findX'
% -Value: value you want to extrapolate. If in 'givenXvalue' mode it is not
%         entered, it will be computed for x=0
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

n=length(x);

xMean=sum(x)/n;
Sxx=sum((x-xMean).^2);

if strcmp('givenXvalue',mode)
    extrapolatedValue=b(1)+b(2)*val;

    confidence=tn_2(n)*sqrt(theta2*(1/n+(val-xMean)^2/Sxx));

    maximum=extrapolatedValue+confidence;
    minimum=extrapolatedValue-confidence;


elseif strcmp('findY',mode)
    extrapolatedValue=b(1)+b(2)*val;

    confidence=tn_2(n)*sqrt(theta2*(1/n+(xMean)^2/Sxx));

    maximum=extrapolatedValue+confidence;
    minimum=extrapolatedValue-confidence;


elseif strcmp('findX',mode)
    extrapolatedValue=(val-b(1))/b(2);


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

end

end

