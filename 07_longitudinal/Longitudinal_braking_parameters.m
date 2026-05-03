%% Constants
g = 9.81; %Gravity [m/s^2]
%% Vehicle Parameters
m = 850; %Mass [kg]
h = 0.2; %Cog height [m]
L = 3.5; %Wheelbase [m]
a = 1.8; %CoG front distance [m]
b = L-a; %CoG rear distance [m]
%% Aero parameters
A = 1.25; %Frontal area [m^2]
Cz = 1.5; %DF coefficient
Cd = 0.6; %Drag coefficient
rho = 1.225; %Air density [kg/m^3]
%% Tyre parameters
%Shape factor
C = 1.7180;
%Stiffness factor
B = 4.1576;
%Curvature factor
E = -22.1100;
%Peak value
a1 = -1e-5;
a2 = 1.25;
%%Brake system parameters
r = 0.375; %Tyre radius [m]
Iwheel = 0.9; %wheel inertia [kgm^2]
rbrake = 3800; %Pedal position to brake torque ratio [Nm/m]
balance = 0.65; %Front to rear brake balance
