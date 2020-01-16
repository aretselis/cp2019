# CP2019

MATLAB scripts developed for the Computational Physics class during my studies at the Physics Department of the Aristotle University of Thessaloniki.

In this class, students are introduced to MATLAB with a focus on applications in:

1) Atmospheric Physics
2) Solid State Physics

# 1) Atmospheric physics

## Wind Rose

For the Wind Rose exercise, students are asked to develop a .m file which imports speed, direction and date information data from an .xlsx (Excel) file to Matlab and uses the [WindRose.m](https://www.mathworks.com/matlabcentral/fileexchange/47248-wind-rose) function to create a wind rose graph for a specified 5-year period as per instructions given during the class.

## Weibull probability distribution function

It has been determined that it is possible to use Weibull probability distribution functions to accurately represent the Wind Potential of a given area. This is to be investigated in MATLAB by importing measurements from a location for a 4-year period and drawing the Weibull probability distribution function over the data.

# 2) Solid State Physics

## eV to nm Converter

A simple converter with basic main menu functionality has been implemented in MATLAB allowing users to calculate a semiconductor's band gap to the corresponding wavelength and vice versa.

## Particle behavior simulator

The code simulates the problem of having N particles in a box which is split in half by a wall, and the wall has a hole which allows only one particle to cross from one side to another. The simulator comes in a basic menu functionality which allows the user to define the following initial conditions:

- All N particles in one half of the box
- N particles split in the two halves of the box based on user's first and last name.

The user can finally choose for how long the simulation shall be performed. 
