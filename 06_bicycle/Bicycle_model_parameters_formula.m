%% Constants
g = 9.81; %Gravity [m/s^2]
%% Vehicle Parameters
m = 1650; %Mass [kg]
I = 3500; %Yaw inertia [kgm^2]
L = 2.8; %Wheelbase [m]
a = 1.10; %CoG front distance [m]
b = L-a; %CoG rear distance [m]
%% Aero parameters
A = 1.80; %Frontal area [m^2]
cz = 0; %DF coefficient
rho = 1.225; %Air density [kg/m^3]
%% Front tyre parameters
%Shape factor
Cf = 1.2947;
%Stiffness factor
Bf = 0.0813;
%Curvature factor
Ef = -8.3966;
%Peak value
a1f = -1e-5;
a2f = 0.95;
%% rear tyre parameters
%Shape factor
Cr = 1.2617;
%Stiffness factor
Br = 0.0925;
%Curvature factor
Er = -8.7012;
%Peak value
a1r = -1e-5;
a2r = 0.95;
%% Steering system parameters
SR = 10; %Steering ratio [deg/deg]
