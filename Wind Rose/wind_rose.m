% Wind Rose Exercise
% Computational Physics and Applications 2019
% Physics Department, Aristotle University of Thessaloniki
% 
% Name: Retselis Anastasios - Faidon
% AEM: 14648
% Developed using MATLAB R2018a

% Data Input and column declaration

filename = 'Wind data.xlsx'; % Define the name of the .xlsx file
wind_data = xlsread(filename); % Read the .xlsx file
year_column = 1; % Define where the year column is in the .xlsx file
month_column = 2; % Define where the month column is in the .xlsx file
speed_column = 5; % Define where the speed column is in the .xlsx file
direction_column = 6; % Define where the direction column is in the .xlsx file

% Find min and max year

year_max = max(wind_data(:,year_column)); % Find the max year from the year column. Directly search in wind_data array.
year_min = min(wind_data(:,year_column)); % Find the min year from the year column. Directly search in wind_data array.

% Randoom year selection

year1 = randi([year_min,(year_max-4)]); % Select a random year as the beginning of the 5 year period.

% Select and read corresponding data

data_begin = find(wind_data == year1, year_column, 'first'); % Search the year column for the first occurence of random selected year
data_end = find(wind_data == (year1+4), year_column, 'last'); %  Search the year column for the last occurence of the last year of the 5 year period.
wind_speed = (wind_data(data_begin:data_end, speed_column)*0.51); % Read corresponding wind speed data from wind_data and convert them to m/s
wind_direction = wind_data(data_begin:data_end, direction_column); % Read corresponding wind direction data from wind_data

% Define options for the wind rose diagram (including title)

Options.AngleNorth = 0;
Options.AngleEast = 90;
Options.Labels = {'N (0)','S (180)','E (90)','W(270)'};
Options.FreqLabelAngle = 30;
Options.TitleString = {sprintf('Wind Rose for the time period %i - %i',year1,year1+4);' '}; % Title options to include the year interval

% Create wind rose diagram

WindRose (wind_direction,wind_speed,Options) % Call the Wind Rose function to create the diagram

% Bins definition

bins_width = 22.5; % Define bins width
bins_start = bins_width/2; % Define center of first bin

bins = bins_start:bins_width:360; % Create a table row vector counting from 12.5 to 360 with a step of 22.5
bins = bins.'; % Convert to column vector

% January direction

month = 1; % Select January
prealloc = 0; % Counter for preallocation

for i = 0:4 % count how many lines of data exist for January
    index = find(wind_data(:,year_column) == (year1+i)& wind_data(:,month_column) == month); % Find the position for the given year AND the given month 
    prealloc = prealloc + max (size(index)); 
end

jan_direction = zeros(prealloc,1); % Preallocate an array to save computational time
i_pos = 1;

for i = 0:4 % i=0 since we begin counting our 5-year period from year1 
    index = find(wind_data(:,year_column) == (year1+i)& wind_data(:,month_column) == month); % Find the position for the given year AND the given month 
    f_pos = i_pos + size(index);
    jan_direction(i_pos:f_pos-1) = wind_data((index(1,:):index(end,:)), direction_column); % Add the corresponding wind direction data to jan_direction
    i_pos = f_pos;
end

% hist(jan_direction,bins) % To be used for visualization only (Disable WindRose first)

% Calculate dominant wind direction

[counts,centers] = hist(jan_direction,bins);
[~,idx] = max(counts); % Identify bin which contains the maximum 
max_interval = (centers(idx,:)) + (bins_width/2); % Define max of corresponding bin
min_interval = (centers(idx,:)) - (bins_width/2); % Define min of corresponding bin
sprintf('Dominant wind direction in bin (%f,%f) with center %f (degrees) for month %d in interval %d - %d', min_interval,max_interval,centers(idx,:),month,year1,year1+4)

% July direction

month = 7; % Select July
prealloc = 0; % Counter for preallocation

for i = 0:4 % count how many lines of data exist for January
    index = find(wind_data(:,year_column) == (year1+i)& wind_data(:,month_column) == month); % Find the position for the given year AND the given month 
    prealloc = prealloc + max (size(index)); 
end

jul_direction = zeros(prealloc,1); % Preallocate an array to save computational time
i_pos = 1;

for i = 0:4 % i=0 since we begin counting our 5-year period from year1 
    index = find(wind_data(:,year_column) == (year1+i)& wind_data(:,month_column) == month); % Find the position for the given year AND the given month 
    f_pos = i_pos + size(index);
    jul_direction(i_pos:f_pos-1) = wind_data((index(1,:):index(end,:)), direction_column); % Add the corresponding wind direction data to jan_direction
    i_pos = f_pos;
end

% hist(jul_direction,bins); % To be used for visualization only (Disable WindRose first)

% Calculate dominant wind direction

[counts,centers] = hist(jul_direction,bins);
[val,idx] = max(counts); % Identify bin which contains the maximum 
max_interval = (centers(idx,:)) + (bins_width/2); % Define max of corresponding bin
min_interval = (centers(idx,:)) - (bins_width/2); % Define min of corresponding bin
sprintf('Dominant wind direction in bin (%f,%f) with center %f (degrees) for month %d in interval %d - %d', min_interval,max_interval,centers(idx,:),month,year1,year1+4)
