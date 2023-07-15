%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Muhammad Ilham Hasby H
% 04191050
% PV model dengan input data sekunder
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Input data CSV Primer dan sekunder PV
% clear all;close all;clc

load DataSekunder.mat

% filename = 'januari2021.xlsx';
% sheet = '01';
% beban = 'D4:D99';
% data = xlsread(filename,sheet, beban);

% data = xlsread(filename,sheet);
% datadigunakan = [data(:,3) data(:,15)];
% dataperjam = datadigunakan(1:4:end,:);
% datakebawah = [dataperjam; dataperjam];
% datakekanan = [dataperjam dataperjam];
% datarotate = flip(dataperjam);
% ambil = datarotate(2:25,:);

%% Data Parameter modul PV MESM-50
Iscs = 3.03;
Imps = 2.81;
Vocs = 22.3;
Vmps = 17.8;
alpha = 0.05/100;
beta = -0.31/100;
Gs = 1000;
Ts = 25;

%% Hasil pengukuran model PV
for i = 1:140
    T = TT(i);
    G = GG(i);
    Imp(i) = Imps*(G/Gs)*(1+(alpha*(T-Ts)));    % Arus maksimum PV
    Vmp(i) = Vmps + (beta*(T-Ts));              % Tegangan maksimum PV
    Pmp(i) = Vmp(i) * Imp(i);                   % Daya maksimum PV
    input(i,:) = [G T];                         % Variabel input PV : Iradiasi & Temperatur
    VoutPV(i,1) = Vmp(i);                       % Tegangan output PV
    IoutPV(i,1) = Imp(i);                       % Arus output PV
    PoutPV(i,1) = Pmp(i);                       % Daya output PV
end

%% Plot hasil model PV
% plot(VoutPV);
% hold on
% plot(IoutPV);
% hold on
% plot(PoutPV);
% xlim([0 140])
% hold on
