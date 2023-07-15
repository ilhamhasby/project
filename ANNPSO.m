% Load data percobaan I/O ANN-PSO
% load percobaanmppt.mat

% Input ANN-PSO
inputs = InputTraining';
% Target ANN-PSO
targets = OutputTraining';
% Jumlah Neuron
n = 10;
% create a noural network
net = feedforwardnet(n);
% Konfigurasikan bobot dan bias ANN
net = configure(net, inputs, targets);
% Dapatkan bobot dan bias ANN normal
getwb(net);
% Fungsi Objektif atau Best Cost 
h = @(x) NMSE(x, net, inputs, targets);

% HARAP DICATAT: Untuk jaringan feed-neuralnetwork dengan n hidden neuron, diperlukan 2*n+n+1 kuantitatif dalam vektor kolom bobot dan bias.
% A. n untuk bobot masukan = (fitur*n) = 2*n
% B. n untuk input bias = (n bias) = ​​n
% C. n untuk bobot keluaran (n bobot)=n
% D. 1 untuk bias keluaran (1 bias)=1

% Menjalankan algoritma pengoptimalan PSO dengan opsi yang diinginkan
[x, predict_pso] = pso(h, 2*n+n+n+1);
net = setwb(net, x');
% Optimisasi bobot dan bias pada ANN-PSO 
getwb(net);
% Error Duty cycle ANN-PSO
error = targets-net(inputs); 
% Menghitung MSE dan RMSE
mse_training = mean((error).^2);
rmse_training = sqrt(mse_training);

%%
%% Testing Data Sekunder

% OutputTestingSekunder = net(InputTestingSekunder');
% mse_err = mse(TargetTestingSekunder', OutputTestingSekunder);
% rmse_err = sqrt(mse_err);
% plot(1:140,OutputTestingSekunder,1:140,TargetTestingSekunder')
% % figure, plotregression(TargetTest, OutputTesting);
% performance_sekunder = perform(net,TargetTestingSekunder',OutputTestingSekunder);


% % %% Testing Data Primer
% % 
% OutputTestingPrimer = net(InputTestingPrimer');
% mse_err2 = mse(TargetTestingPrimer', OutputTestingPrimer);
% rmse_err2 = sqrt(mse_err2);
% plot(1:30,OutputTestingPrimer,1:30,TargetTestingPrimer')
% figure, plotregression(TargetTestingPrimer', OutputTestingPrimer);
% % performance_primer = perform(net,TargetTestingPrimer',OutputTestingPrimer);


% %% Testing Data Primer

% OutputTestingPengukuran = net(InputTestingPengukuran');
% mse_err2 = mse(TargetTestingPengukuran', OutputTestingPengukuran);
% rmse_err2 = sqrt(mse_err2);
% plot(1:30,OutputTestingPengukuran,1:30,TargetTestingPengukuran')
% % figure, plotregression(TargetTestingPrimer', OutputTestingSekunder);
% performance_primer = perform(net,TargetTestingPengukuran',OutputTestingPengukuran);
