% eV2nm Converter
% Computational Physics and Applications 2019
% Physics Department, Aristotle University of Thessaloniki
% 
% Name: Retselis Anastasios - Faidon
% AEM: 14648
% Developed using MATLAB R2018a

% constants
clear; % clear constants
clc; % clear command window
c = 3e8; % m/s, light speed 
h = 4.1356678e-15; % eV s, plank constant
running = 1; % for loop


while running == 1
    
% Ask which convertion shall be performed    
disp('Welcome to the eV - nm converter!');
disp('Choose the desired conversion:');
disp('1 = eV to nm');
disp('2 = nm to eV');
disp('3 = Exit program');

% Gather user input

user_input = input('Enter corresponding number:');
while ~(user_input == 1 || user_input==2 || user_input==3) % Apply not logic, to stop wrong choices
    user_input = input('Incorrect choice. Enter 1,2 or 3:');
end

% eV to nm conversion

if user_input == 1
    energy = input('Enter semiconductor''s band gap in eV = ');
    while (energy<0)
        disp('Band gap cannot be negative or zero!');
        energy = input('Enter semiconductor''s band gap in eV = ');
    end
    wavelength = ((h*c)/energy)*10^9;
    fprintf('\nWavelength = %.4f nm\n',wavelength);

% nm to eV conversion
    
elseif user_input == 2 
    wavelength = input('Enter wavelength in nm = ');
    while (wavelength<=0)
        disp('Wavelength cannot be negative or zero!');
        wavelength = input('Enter wavelength in nm = ');
    end
    energy = (h*c)/(wavelength*10^(-9));
    fprintf('\nSemiconductor''s band gap = %.4f eV\n',energy);

% Exit program if 3

else  
    disp('Goodbye!');
    break;
end
    
% Ask if another convertion shall be performed

disp('Run another convertion?');
disp('1 = Yes');
disp('2 = No');

rerun_input = input('Enter corresponding number:');
while ~(rerun_input == 1 || rerun_input==2) % Apply not logic, to stop wrong choices
    rerun_input = input('Incorrect choice. Enter 1 or 2:');
end

if rerun_input == 1 
    running = 1; % keep program running
    clc; %clear command window
    disp('Rerunning...');
else 
   	running = 0; % indicate program to end
    disp('Goodbye!');
end
end