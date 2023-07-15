function NMSE_calc = NMSE( wb, net, input, target)
% wb adalah vektor baris bobot dan bias yang diperoleh dari algoritma genetika.
% Itu harus dialihkan saat mentransfer bobot dan bias ke jaring jaringan.
net = setwb(net, wb');
% Matriks output bersih diberikan oleh net (input). Matriks kesalahan yang sesuai diberikan oleh
error = target - net (input);
% Kesalahan kuadrat rata-rata yang dinormalisasi dengan varian target rata-rata adalah
NMSE_calc = mean (error.^2)/mean (var(target',1));
% Itu tidak tergantung pada skala komponen target dan terkait dengan statistik Rsquare melalui
% Requare = 1 - NMSEcalc (lihat Wikipedia)