%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Muhammad Ilham Hasby H
% 04191050
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear all;close all;clc

%% Output BBC
% Vi = VoutLoadall;
% Ii = Ioutall;

%% Parameter Output (Baterai)
% Spesifikasi beban baterai model Yuasa NP2-12
Vb = 12; % Tegangan nominal baterai
Ib = 2; % Arus kerja baterai 
In = 1.86; % Arus nominal baterai

%Inisialisasi vektor keluaran
% Vx = 0:Vb/15:Vb;
% Iy = 0:Ib/5:Ib;
% Vx = 12:Vb;
% Iy = 2:Ib;

%% Plot grafik parameter
% plot(Vx);
% hold on
% plot(Iy)
% ylim([0 15])
% figure(1)
% hold on
% title('Karakteristik Baterai');
% ylabel('Arus [A]');
% xlabel('Tegangan [V]');
% plot(Vx,Iy,'linewidth',3)% 
% hold off
% grid on

% Hasil keluaran
fprintf('Model info: Baterai Yuasa NP2-12\n'); % Model info
fprintf('Ib = ');disp(Ib); % Current battery value
fprintf('Vb = ');disp(Vb); % Voltage battery value
