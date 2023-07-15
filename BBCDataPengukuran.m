%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Muhammad Ilham Hasby H
% 04191050
% BBC Model dengan input data input pengukuran PV
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Perhitungan tegangan output berdasarkan dari PV yang mengacu terhadap data iradiasi dan temperatur yang berubah
clear all;close all;clc
% Input data primer (sampel) hasil pengukuran 
load datapengukuransampel.mat

%% Parameter input konverter buck-boost
Ppv = 50; % Daya PV
Vin = Tegangan; % Tegangan PV (V) >> Vin = VoutPV(1,1);
Iin = Arus; % Arus PV (A)
Pin = Vin.*Iin; % Daya keluaran PV (W)

%% Parameter output konverter buck-boost
Vout = 12; % Tegangan baterai (V)
Iout = 2; % Arus baterai (A)
Pout = Vout.*Iout; % Daya baterai (W)
Fs = 20000; % Frekuensi switching (Hz)
dVout = Vout.*0.01; % Ripple tegangan output(V)
Ts = 1/Fs; % Periode switching (s)


[Jumlahdata,x] = size(Tegangan);

Ioutall = zeros(Jumlahdata)
Dall = zeros(Jumlahdata)
VoutLoadall = zeros(Jumlahdata)
PoutBBCall = zeros(Jumlahdata)

for n = 1:Jumlahdata
    
Vin = Tegangan(n); % Tegangan PV (V) 
Iin = Arus(n); % Arus PV (A)
Pin = Vin*Iin; % Daya keluaran PV (W)
Vout = 12; % Tegangan baterai (V)
Iout = 2; % Arus baterai (A)
Pout = Vout*Iout; % Daya baterai (W)
Fs = 20000; % Frekuensi switching (Hz)
dVout = Vout*0.01; % Ripple tegangan output(V)
Ts = 1/Fs; % Periode switching (s)

%% Menghitung parameter buck-boost konverter
D = Vout/(Vin+Vout); % Duty cycle mode (%) 
R = Vout/Iout; % Nilai resistor (ohm)
L = ((1-D)^2 * R)/(2*Fs); % Nilai induktor (H)
C = (Vout*D)/(R*Fs*dVout); % Nilai kapasitor (F)

%% Menghitung variabel buck-boost konverter
ILmax = ((Vin*D)/(R*((1-D)^2))) + ((Vin*D*Ts)/(2*L)); % Arus induktor maksimum (A)
ILmin = ((Vin*D)/(R*((1-D)^2))) - ((Vin*D*Ts)/(2*L)); % Arus induktor minimum (A)
IoutLoad = (ILmax-ILmin)*D/2; % Arus keluaran buck-boost konverter (A)
Icmax = ILmax - Iout;% Arus kapasitor maksimum (A)
Icmin = ILmin - Iout; % Arus kapasitor minimum (A)
Ic = Iout; % Arus kapasitor (A)
IL = Iin+Iout; % Arus induktor (A)
Dbuck = Vout/Vin; % Duty cycle buck (%)
VoutLoad = D*(Vin+Vout); % Tegangan keluaran buck-boost konverter
Po = Vin*IoutLoad; % Daya target keluaran buck-boost konverter (W) 
PoutBBC = IoutLoad*VoutLoad; % Daya hasil keluaran buck-boost konverter

%% Parameter Output BBC
Ioutall(n) = IoutLoad;
Dall(n) = D;
VoutLoadall(n) = VoutLoad;
PoutBBCall(n) = PoutBBC;

%% Hasil variabel komponen konverter buck-boost
fprintf('Model info:\n'); 
fprintf('Dbuck = ');disp(D);
fprintf('R = ');disp(R);
fprintf('L = ');disp(L);
fprintf('C = ');disp(C);
fprintf('Ic = ');disp(Ic);
fprintf('IL = ');disp(IL);
fprintf('Dboost = ');disp(Dbuck);
fprintf('VoutLoad = ');disp(VoutLoad);
fprintf('Io = ');disp(IoutLoad);

n
end

%% Inisialisasi vektor output
% I = 0:Io/100:Io;
% Vi = 0:Vin/100:Vin;
% Vo = 0:Vout/100:Vout;
% P = 0:Po/100:Po; 

% %% Plot output grafik
% plot(Dall);
% hold on
% plot(VoutLoadall,'r');
% hold on
% plot(Ioall)
% ylim([0 15])
plot(PoutBBCall)
hold on
% hold off

% figure(1)
% hold on
% title('Karakteristik BBC');
% ylabel('Arus [A]');
% xlabel('Tegangan [V]');
% plot(Vi,I,'linewidth',3)%  
% grid on
% hold off
% figure(2) 
% hold on
% title('Karakteristik BBC');
% ylabel('Daya [W]');
% xlabel('Tegangan [V]');
% plot(Vo,P,'linewidth',3)%
% grid on
% hold off
