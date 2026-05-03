%% Constants
g = 9.81; %Gravity [m/s^2]
%% Vehicle parameters - mass and inertia
m = 850; %Mass [kg]
musf = 15.00; %Front corner unsprung mass [kg]
musr = 17.50; %Rear corner unsprung mass [kg]
ms = m-(musf+musr); %Sprung mass [kg]
I = 3500; %Yaw inertia [kgm^2]
Ixx = 300; %Roll inertia [kgm^2]
Iyy = 1350; %Pitch inertia [kgm^2]
%% Vehicle parameters - dimensions
h = 0.2; %Cog height [m]
L = 3.5; %Wheelbase [m]
a = 1.8; %CoG front distance [m]
b = L-a; %CoG rear distance [m]
tf = 1.75; %Front wheel track [m]
tr = 1.85; %Rear wheel track [m]
r = 0.375; %Wheel radius [m]
hcog = r; %Centre of height [m]
hrcf = 0.04; %Front roll centre height [m]
hrcr = 0.06; %Rear roll centre height [m]
hrc = 0.05; %Roll centre height [m]
husmf = r; %Front unsprung mass height [m]
husmr = r; %Rear unsprung mass height [m]
%% Aero parameters
A = 1.25; %Frontal area [m^2]
Cz = 1.0; %DF coefficient
rho = 1.225; %Air density [kg/m^3]
%% Suspension parameters
ksf = 67500; %Front spring stiffness [N/m]
ksr = 100000; %Rear spring stiffness [N/m]
cdf = 1400; %Front damping coefficient [Ns/m]
cdr = 1800; %Rear damping coefficient [Ns/m]
%% Tyre parameters
ktyre = 400000; %Tyre vertical stifness [N/m]
karbf = 5000; %Front ARB stiffness [Nm/rad]
karbr = 1000; %Rear ARB stiffness [Nm/rad]
z0tfl = (0.5*ms*b/L+musf)*g/ktyre; %Definition of the front left tyre at equilibrium [m]
z0tfr = (0.5*ms*b/L+musf)*g/ktyre; %Definition of the front left tyre at equilibrium [m]
z0trl = (0.5*ms*a/L+musr)*g/ktyre; %Definition of the front left tyre at equilibrium [m]
z0trr = (0.5*ms*a/L+musr)*g/ktyre; %Definition of the front left tyre at equilibrium [m]
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
