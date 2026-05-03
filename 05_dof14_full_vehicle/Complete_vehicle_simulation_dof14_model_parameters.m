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
Cd = 0.4; %Drag coefficient
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
%% Steering system parameters
SR = 20; %Steering ratio [deg/deg]
%%Brake system parameters
r = 0.375; %Tyre radius [m]
Iwheel = 0.9; %wheel inertia [kgm^2]
rbrake = 3800; %Pedal position to brake torque ratio [Nm/m]
balance = 0.65; %Front to rear brake balance
%%Powertrain system parameters
igear = [23.10, 17.64, 13.86, 10.92, 8.82, 7.14, 5.88, 4.33]'; %Gear ratios
Tengmax = 250; %Maximum engine torque [Nm]
throttlepos = [0, 0.25, 0.5, 0.75, 1]'; %Throttle positions in engine map
enginerpm = linspace (1000,15000,15)'; %Engine rpm in engine map [rpm]
enginemap = [-0.15, 0.23, 0.60, 0.68, 0.8;
    -0.17, 0.26, 0.62, 0.69, 0.82;
    -0.2, 0.23, 0.63, 0.71, 0.86;
    -0.3, 0.2, 0.62, 0.72, 0.89;
    -0.4, 0.18, 0.61, 0.72, 0.91;
    -0.5, 0.17, 0.58, 0.74, 0.93;
    -0.58, 0.16, 0.54, 0.76, 0.95;
    -0.68, 0.15, 0.50, 0.78, 0.98;
    -0.75, 0.10, 0.45, 0.77, 1.00;
    -0.83, 0.06, 0.40, 0.76, 1.00;
    -0.93, -0.03, 0.32, 0.70, 0.98;
    -1.02, -0.08, 0.23, 0.62, 0.96;
    -1.10, -0.15, 0.16, 0.52, 0.93;
    -1.20, -0.20, 0.08, 0.42, 0.88;
    -1.25, -0.30, 0.00, 0.34, 0.84]; %Engine map normalized
rpm_idling = 1000; %Engine rpm during idling [rpm]
rpm_limit = 15000; %Maximum engine rpm [rpm]
rpm_up = 13500; %Engine rpm for upshifting [rpm]
rpm_down = 7000; %Engine rpm for downshifting [rpm]