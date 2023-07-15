%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Muhammad Ilham Hasby H
% 04191050
% Karakterisasi PV
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% clear all;close all;clc

%% Input sampel data primer dan sekunder PV

it = input('Masukkan jumlah kurva yang ingin Anda plot: 1,2...N: ');
for N = 1:it;
%% Data modul PV MESM-50
T = input('Masukkan nilai Temperatur (°C): ');            % Suhu sel dalam °C
G = input('Masukkan nilai radiasi matahari (°W/m2): ');   % Iradiasi Matahari dalam W/m2
ai = 0.05/100;                                            % Koefisien Suhu Tegangan (ki)
av = -0.31/100;                                           % Koefisien Suhu Tegangan (kv)
Isc_r = 3.03;                                             % Arus hubung singkat (A)
Voc_r = 22.3;                                             % Tegangan sirkuit terbuka (V)
Vm = 17.8;                                                % Tegangan maksimum PV (V)
Im = 2.81;                                                % Arus maksimum PV (A)
Pm = 50;                                                  % Daya maksimum PV (W)
Ns = 36;                                                  % Jumlah sel PV    
n = 1.5;                                                  % Faktor idealitas dioda

%% Parameter PV
Gr = 1000;                                                      % Nominal Iradiasi (W/m^2)
T = T+273.6;                                                    % Temperatur dalam satuan Kelvin (K)
Tr = 25 +273.6;                                                 % Nominal Suhu (K)
dT = T-Tr;                                                      % Selisih temperatur (K)
Isc = Isc_r+ai*dT;                                              % Pengaruh Isc terhadap delta T
Voc = Voc_r+av*dT;                                              % Pengaruh Voc terhadap delta T
q = 1.60217646*power(10,-19);                                   % Konstanta muatan elektron (C)
K = 1.3806503*power(10,-23);                                    % Konstanta Boltzmann (J/K)
Vt = (Ns*n*K*T/q);                                              % Tegangan Termal (V) 
Eg = 1.12;                                                      % Gap-energi
Iph = Isc*(G/Gr);                                               % Arus photon (A)
Iss = (Isc)/(exp(Voc/Vt)-1);                                    % Arus saturasi (A)
Is = Iss*((T/Tr)^3)*exp(((q*Eg)/(n*K))*((1/Tr)-(1/T)));         % Arus saturasi dioda (A)
Rs = 1.6;                                                       % Resistansi seri (ohm) 
Rp = 80;                                                        % Resistansi parallel (ohm)

%% Inisialisasi vektor parameter
I = Iph;                                   % Inisialisasi arus input (A)
V = 0:(Voc/100):Voc;                       % Inisialisasi vektor tegangan (V)
for n1 = 1:length(V) 
    
        
    for n2 = 1:20                          
    Vd = (V(n1)+Rs*I);                     % Tegangan dioda (V)
    Id = Is*(exp(Vd/Vt)-1);                % Arus dioda (A)
    Ip = Vd/Rp;                            % Arus resistansi parallel
    f = Iph-I-Id-Ip;                       % Hukum kirchoff(I) sum(I) = 0
    df = -1-(Is*Rs/Vt)*exp(Vd/Vt)-(Rs/Rp); % Derivative f'(I) = 0
    I = I-f/df;                            % Formula Newton-Raphson
    
    end                                  
    
    if I<0
        I = 0;
    end
    Ipv(n1) = I;                           % Akumulasi arus output (A) 

end 
P=Ipv.*V;                                  % Akumulasi daya output (W)

%% Plot kurva karakteristik
figure(1)
hold on
plot(V,Ipv,'linewidth',2)               % Output kurva I-V
title('Karakteristik I-V');
ylabel('Arus [A]');
xlabel('Tegangan [V]');
grid on
figure(2)
plot(V,P,'linewidth',2)                 % Output kurva P-V 
title('Karakteristik P-V');
ylabel('Daya [W]');
xlabel('Tegangan [V]');
hold on
grid on
end

%% Hasil model PV
fprintf('Model info: PV MESM-50W\n');
fprintf('Iph = ');disp(Iph);
fprintf('Id = ');disp(Id);
fprintf('Rs = ');disp(Rs);
fprintf('Rp = ');disp(Rp);
% fprintf('Ipv = ');disp(Ipv,1*1);
% fprintf('V = ');disp(V,1*1);
% fprintf('P = ');disp(P);
