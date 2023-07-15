clear all
close all
Iscs = 3.03; % Short circuit current PV
Imps = 2.81; % Maximum current PV
Vocs = 22.3; % Open circuit voltage PV
Vmps = 17.8; % Maximum voltage PV
alpha = 0.0005; % Current temperature coefficient
beta = -0.0031; % Voltage temperature coefficient
Gs = 1000; % Standar irradiance 1000 W/m2
Ts = 25; % Standar temperature 25 degree 
for i = 1:1000
    Tmin = 15;
    Tmax = 45;
    T = (Tmax-Tmin)*rand + Tmin; % Temperature
    Gmin = 0;
    Gmax = 1000;
    G = (Gmax-Gmin)*rand +Gmin; % Irradiance
    Imp(i) = Imps*(G/Gs)*(1+(alpha*(T-Ts))); % Maximum current of the given irradiance amd temperature
    Vmp(i) = Vmps + (beta*(T-Ts)); % Maximum voltage of the given irradiance and te,[erature
    Pmp(i) = Vmp(i)*Imp(i); % Maximum power of the given irradiance and temperature
    input(i,:) = [G,T];
    output(i,1) = Vmp(i);
    IoutPV(i,1) = Imp(i);
    PoutPV(i,1) = Pmp(i);
    % output(i,2) = [VoutPV,IoutPV];
end
% ANNPSO