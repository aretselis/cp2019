% Nanoparticles in a box simulator
% Computational Physics and Applications 2019
% Physics Department, Aristotle University of Thessaloniki
% 
% Name: Retselis Anastasios - Faidon
% AEM: 14648
% Developed using MATLAB R2018a
% CPU used: Intel Core i5-3570 @ 3.40 GHz

% Parameters declaration

clear;
clc;
running = 1; % parameter to keep program running
simulation_time = 100000; % define simulation time

% Program begin

while running == 1 %keep programm running if true
    
disp('Welcome to the particle in a box simulator!');
disp('Initially, particles can be either in one half of the box or in both');
disp('Choose the desired simulation:');
disp('1 = Particles in one part');
disp('2 = Particles in both parts');
disp('3 = Exit program');
    
% Gather user input

user_input = input('Enter corresponding number:');
while ~(user_input == 1 || user_input==2 || user_input==3) % Apply not logic, to stop wrong choices
user_input = input('Incorrect choice. Enter 1,2 or 3:');
end

% Particles in one part simulation

if user_input == 1
        clc;
        disp('All the particles in one part of the box');
        fprintf('Simulation time is %d seconds.\n', simulation_time);
        disp('Choose the amount of particles:');
        disp('1 = 1000');
        disp('2 = 10,000');
        disp('3 = 100,000');
        
        % Gather user input
        
        user_input = input('Enter corresponding number:');
        while ~(user_input == 1 || user_input==2 || user_input==3) % Apply not logic, to stop wrong choices
             user_input = input('Incorrect choice. Enter 1,2 or 3:');
        end
        
        % Register number of particles in one part
        
        if user_input==1
            particles = 1000;
        elseif user_input==2
            particles = 10000;
        else
            particles = 100000;
        end
        
        % Begin the simulation
        
        tic; % Start the counter
        clf;
        % Theoretical
        nt = @(t) (particles/2)*(1+exp((-2*t)/particles)); % Define the function to be used
        fplot(nt, [0 simulation_time], 'r','LineWidth', 1.7); % Plot the function over the simulation time
        title(sprintf('Particle simulation \n Initial state: N=%d particles in one part of the box', particles));
        xlabel('Time [seconds]');
        ylabel('Number of particles in one part (half)');
        % Actual
        half1 = zeros(simulation_time+1,1);
        half1(1,:) = particles;
        half2 = zeros(simulation_time+1,1);
        for i=2:(simulation_time+1)
            a = rand; % Get a random number in (0,1)
            if a <= ((half1(i-1,:))/particles) % Movement from half 1 to half 2
                half1(i,:) = (half1(i-1,:) - 1);
                half2(i,:) = (half2(i-1,:) + 1);
            else % Movement from half 2 to half 1
                half1(i,:) = (half1(i-1,:) + 1);
                half2(i,:) = (half2(i-1,:) - 1);
            end
        end
        hold on;
        plot(half1(:,1), 'b','LineWidth', 0.2);
        legend({'Theoretical behavior: $$Na=\frac{N}{2}\begin{pmatrix}1+e^{\frac{-2t}{N}}\end{pmatrix}$$','Actual behavior'},'Interpreter','latex');
        run_time = toc; % Register simulation run time
        fprintf('\n The simulation took %.4f seconds to complete.\n\n',run_time);
        
    % Simulation for particles in both parts of the box
        
    elseif user_input==2
        clc;
        disp('For particles in both parts, users need to provide additional information');
        fprintf('Simulation time is %d seconds.\n', simulation_time);
        disp('Choose the amount of particles:');
        disp('1 = 1000');
        disp('2 = 10,000');
        disp('3 = 100,000');
             
        % Gather user input
        
        user_input = input('Enter corresponding number:');
        while ~(user_input == 1 || user_input==2 || user_input==3) % Apply not logic, to stop wrong choices
             user_input = input('Incorrect choice. Enter 1,2 or 3:');
        end
        
        % Register total number of particles
        
        if user_input==1
              particles = 1000;
          elseif user_input==2
                particles = 10000;
          else
              particles = 100000;
        end
        
        name = input('Enter your first name (Latin characters): ', 's');
        surname = input('Enter your surname (Latin characters): ', 's');
                
        % Name to ASCII and min/max ration
        
        ON = sum(double(name)); % Convert to ASCII and add the numbers
        EP = sum(double(surname)); % Convert to ASCII and add the numbers
        ratio = min(ON,EP)/max(ON,EP); % Calculate the min/max ratio
        N2 = round((particles/(ratio+1))); % Calculate N2
        N1 = particles - N2; % Calculate N1
        
        % Begin the simulation
        
        tic; % Start the counter
        clf;
        nt = @(t) (particles/2)*(1+exp((-2*t)/particles)); % Define the function to be used
        fplot(nt, [0 simulation_time]); % Plot the function over the simulation time
        % Actual
        half1 = zeros(simulation_time+1,1);
        half1(1,:) = N1;
        half2 = zeros(simulation_time+1,1);
        half2(1,:) = N2;
        for i=2:(simulation_time+1)
            a = rand; % Get a random number in (0,1)
            if a <= ((half1(i-1,:))/particles) % Movement from half 1 to half 2
                half1(i,:) = (half1(i-1,:) - 1);
                half2(i,:) = (half2(i-1,:) + 1);
            else % Movement from half 2 to half 1
                half1(i,:) = (half1(i-1,:) + 1);
                half2(i,:) = (half2(i-1,:) - 1);
            end
        end
        hold on;
        plot(half1(:,1), 'b','LineWidth', 0.2);
        plot(half2(:,1), 'r','LineWidth', 0.2);
        title(sprintf('Particle simulation \n Initial state: N1=%d particles on one half \n and N2=%d particles on the other half', N1,N2));
        xlabel('Time [seconds]');
        ylabel('Number of particles');
        legend({'Theoretical behavior: $$Na=\frac{N}{2}\begin{pmatrix}1+e^{\frac{-2t}{N}}\end{pmatrix}$$','Left part of the box','Right part of the box'},'Interpreter','latex');
        run_time = toc; % Register simulation run time
        fprintf('\n The simulation took %.4f seconds to complete.\n\n',run_time);
                
    % Exit program if 3

 else  
    disp('Goodbye!');
    break;
end

% Ask if another simulation shall be performed

disp('Run another simulation?');
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

