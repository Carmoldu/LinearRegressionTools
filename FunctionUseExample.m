%%
%EXAMPLE OF USE OF THE STATISTICAL ANALYSIS FUNCTIONS

%IMPORT DATA
%The data used as example is organised in the next columns:
% 1-aileron deflection
% 2-Rudder deflection
% 3-Sideslip angle
% 4-Roll/bank angle
% 5-Lateral velocity Ve
% 6-IAS (indicated airspeed)
% 7-Cw
%
%We will only use two colums to do linear regressions

data120CR=importdata('120CR.txt'); %I like using txt to import the data, if you want to import an excel do it yourselves! :P


%%
%EXAMPLE
%If you have any doubt about any function, type in the command console
%"help" + the name of the function, all of them have clear explanations

x = data120CR(:,5);
y = data120CR(:,4);

%Remove outliers
[ xNew, yNew ,~, bOld] = removeOutliers( x, y, 1, 'Removing outliers', 'Ve', 'Roll angle' );
legend('Data points','linear fit','Removed points','95% confidence limits')

%Linear fit
[  b, Rsq, theta21, deltaBeta0, deltaBeta1, ~] = linearFit( xNew, yNew, 2, 'Linear fit', 'Ve', 'Roll angle' );
legend('Data points','linear fit')

%Extrapolation
[  b, Rsq, theta22, deltaBeta0, deltaBeta1, ~] = linearFit( xNew, yNew, 3, 'Extrapolation', 'Ve', 'Roll angle' );

[ extrapolatedValue, maximum, minimum] = extrapolate( b, xNew, theta22, 'givenXvalue', 80);
[ extrapolatedValue, maximum, minimum] = extrapolate( b, xNew, theta22, 'findY');
[ extrapolatedValue, maximum, minimum] = extrapolate( b, xNew, theta22, 'findX');
plotExtrapolation( b, xNew, theta2, -60, 80, 3 );

legend('Data points','linear fit','Extrapolated value','Extrapolation interval')

%Prediction interval
[  b, Rsq, theta21, deltaBeta0, deltaBeta1, ~] = linearFit( x, y, 4, 'Prediction Interval', 'Ve', 'Roll angle' );

plotPredictionInterval( b, x, theta21, -60,80, 4);
legend('Data points','linear fit','Prediction interval')


