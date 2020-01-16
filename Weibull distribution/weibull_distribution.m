% Wind Potential using Weibull Distribution
% Computational Physics and Applications 2019
% Physics Department, Aristotle University of Thessaloniki
% 
% Name: Retselis Anastasios - Faidon
% AEM: 14648
% Developed using MATLAB R2018a
% Uses Statistics and Machine Learning Toolbox

clear;

% Data Input and Column declaration
aem = 14648; % Define user's AEM
filename = 'Weibull data.xlsx'; % Define the name of the .xlsx file

if (mod(aem,2)==0) % If even AEM, read station_2
    fprintf('User has even AEM, reading station_2 data\n')
    wind_data = xlsread(filename,'station_2');
    speed_column = 5; % Define where the speed column is in the .xlsx file
else % If odd AEM, read station_1
    fprintf('User has odd AEM, reading station_1 data\n')
    wind_data = xlsread(filename,'station_1');
    speed_column = 6; % Define where the speed column is in the .xlsx file
end 
year_column = 1; % Define where the year column is in the .xlsx file

% Find min and max year

year_max = max(wind_data(:,year_column)); % Find the max year from the year column. 
year_min = min(wind_data(:,year_column)); % Find the min year from the year column. 

% Randoom year selection

year1 = randi([year_min,(year_max-3)]); % Select a random year as the beginning of the 4 year period.

% Select and read corresponding data

data_begin = find(wind_data == year1, year_column, 'first'); % Search the year column for the first occurence of random selected year
data_end = find(wind_data == (year1+3), year_column, 'last'); %  Search the year column for the last occurence of the last year of the 4 year period.
wind_speed = (wind_data(data_begin:data_end, speed_column)*0.51); % Read corresponding wind speed data from wind_data and convert them to m/s

% Weibull distribution

wind_speed = wind_speed.'; % Transfrom to row vector
parameters = wblfit(nonzeros(wind_speed)); % Obtain parameters for Weibull distribution
fprintf('Weibull distribution parameters are: C = %f and k = %f\n', parameters(1), parameters(2)) % Based on the definitionn of wblfit

% Round wind speed and find wind min and max wind speed

wind_max = max(wind_speed); % Find the max wind speed. 
wind_min = min(nonzeros(wind_speed)); % Find the min wind speed.
wind_speed = round(wind_speed); % Round the speeds in the wind speed table.

% Count the frequency of each value

frequency = tabulate(nonzeros(wind_speed)); % Calculate the frequency of each value in the wind_speed table
frequency(:,3) = frequency(:,3)/100; % Change percentage to decimal
measurements = sum(frequency); % Sum to check if probability = 1 and to add total amount of measurements to graph
linear_space = 0:1:max(frequency(:, 1));

% Create the graph

clf('reset'); % Reset old graph
bar(frequency(:,1),frequency(:,3)); % Plot the bars 
hold on; % Draw multiple plots in figure
plot(linear_space,wblpdf(linear_space,parameters(1),parameters(2)),'r', 'LineWidth', 0.85); % Draw Weibull distribution

% Graph options

xlabel('Wind speed (m/s)'); % X Axis Label
ylabel('Probability'); % Y Axis Label
title(sprintf('Weibull wind speed probability distribution for the time period %d - %d \n  For %d non-zero measurements \n (out of %d total measurements)',year1,year1+3,measurements(:,2),max(size(wind_speed)))); % Title
legend('Experimental data', sprintf('Fitted Weibull probability \ndistribution function')); % Legend 
