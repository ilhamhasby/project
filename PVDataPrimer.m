%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Muhammad Ilham Hasby H
% 04191050
% PV model dengan input data primer (sampel)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% clear all;close all;clc

%% Input data CSV PV
load DataPrimer.mat

%% Data Parameter modul PV MESM-50
Iscs = 3.03;
Imps = 2.81;
Vocs = 22.3;
Vmps = 17.8;
alpha = 0.05/100;
beta = -0.31/100;
Gs = 1000;
Ts = 25;

% [Jumlahdata,x] = size(G);
% IoutPV = zeros(Jumlahdata)
% VoutPV = zeros(Jumlahdata)

%% Hasil pengukuran model PV
for i = 1:6
    G = Iradiation_G_(i);
    T = Temperatur_T_(i);
    Imp(i) = Imps*(G/Gs)*(1+(alpha*(T-Ts)));    % Arus maksimum PV
    Vmp(i) = Vmps + (beta*(T-Ts));              % Tegangan maksimum PV
    Pmp(i) = Vmp(i) * Imp(i);                   % Daya maksimum PV
    input(i,:) = [G T];                         % Variabel input PV : Iradiasi & Temperatur
    VoutPV(i,1) = Vmp(i);                       % Tegangan output PV
    IoutPV(i,1) = Imp(i);                       % Arus output PV
    PoutPV(i,1) = Pmp(i);                       % Daya output PV

%% Parameter Output PV
% IoutPV(i) = IoutPV;
% VoutPV(i) = VoutPV;

end
%%
% Plot hasil model PV
% plot(VoutPV);
% hold on
% plot(IoutPV);
% hold on
% plot(PoutPV);
% hold on
% 
