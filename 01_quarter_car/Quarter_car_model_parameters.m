%% Constants
g = 9.81; %Gravity [m/s^2]
%%Vehicle parameters
ms = 400; %Sprung mass
mus = 30; %Unsprung mass
%%Suspension parameters
kspring = 35500; %Spring stiffness [N/m]
F0 = 3924; % Spring preload [N]
cdamper = 1500; %Damping coefficient [Ns/m]
ktyre = 300000; %Tyre stifness [N/m]
z0tyre = (ms+mus)*g/ktyre; %Definition of the tyre at equilibrium [m]