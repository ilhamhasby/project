% Solve an Input-Output Fitting problem with a Neural Network
% Script generated by Neural Fitting app
% Created 20-May-2023 20:29:41

x = InputTraining';
t = OutputTraining';

hiddenLayerSize = 10;
trainFcn = 'trainlm';

% PSO Parameters
numParticles = 20;  % Number of particles in the swarm
maxIterations = 100;  % Maximum number of iterations
c1 = 2;  % Cognitive coefficient
c2 = 2;  % Social coefficient
w = 0.7;  % Inertia weight

% Initialize particle positions and velocities
particlePositions = zeros(hiddenLayerSize, numParticles);
particleVelocities = zeros(hiddenLayerSize, numParticles);
particleBestPositions = particlePositions;
globalBestPosition = particlePositions(:, 1);
globalBestFitness = inf;

for i = 1:numParticles
    % Randomly initialize particle positions within a defined range
    particlePositions(:, i) = rand(hiddenLayerSize, 1);

    % Evaluate fitness of the particle's initial position
    net = fitnet(particlePositions(:, i)', trainFcn);
    [net, tr] = train(net, x, t);
    y = net(x);
    fitness = perform(net, t, y);

    % Update personal best and global best
    particleBestPositions(:, i) = particlePositions(:, i);
    if fitness < globalBestFitness
        globalBestPosition = particlePositions(:, i);
        globalBestFitness = fitness;
    end
end

% PSO iterations
for iteration = 1:maxIterations
    for i = 1:numParticles
        % Update velocity
        particleVelocities(:, i) = w * particleVelocities(:, i) + ...
            c1 * rand(size(particlePositions(:, i))) .* ...
            (particleBestPositions(:, i) - particlePositions(:, i)) + ...
            c2 * rand(size(particlePositions(:, i))) .* ...
            (globalBestPosition - particlePositions(:, i));

        % Update position
        particlePositions(:, i) = particlePositions(:, i) + particleVelocities(:, i);

        % Clamp particle positions to the defined range if necessary

        % Evaluate fitness of the new position
        net = fitnet(particlePositions(:, i), trainFcn);
        [net, tr] = train(net, x, t);
        y = net(x);
        fitness = perform(net, t, y);

        % Update personal best and global best
        if fitness < perform(net, t, y)
            particleBestPositions(:, i) = particlePositions(:, i);
            if fitness < globalBestFitness
                globalBestPosition = particlePositions(:, i);
                globalBestFitness = fitness;
            end
        end
    end
end

% Use the global best position as the optimized parameters for the ANN
optimizedHiddenLayerSize = globalBestPosition;

% Create a Fitting Network with the optimized parameters
optimizedNet = fitnet(optimizedHiddenLayerSize, trainFcn);

% Setup Division of Data for Training, Validation, Testing
optimizedNet.divideParam.trainRatio = 70/100;
optimizedNet.divideParam.valRatio = 15/100;
optimizedNet.divideParam.testRatio = 15/100;

% Train the Network
[optimizedNet, tr] = train(optimizedNet, x, t);

% Test the Network
y = optimizedNet(x);
e = gsubtract(t, y);
performance = perform(optimizedNet, t, y);

% View the Network
view(optimizedNet);

% Plots
% Uncomment these lines to enable various plots.
% figure, plotperform(tr)
% figure, plottrainstate(tr)
% figure, ploterrhist(e)
% figure, plotregression(t, y)
% figure, plotfit(optimizedNet, x, t)

%%
%% Testing Data Sekunder

% OutputTestingSekunder = net(InputTestingSekunder');
% mse_err = mse(TargetTestingSekunder', OutputTestingSekunder);
% rmse_err = sqrt(mse_err);
% % figure, plotregression(TargetTest, OutputTesting);
% performance_sekunder = perform(net,TargetTestingSekunder',OutputTestingSekunder);
% plot(1:140,OutputTestingSekunder,1:140,TargetTestingSekunder')

% % %% Testing Data Primer
% % 
% OutputTestingPrimer = net(InputTestingPrimer');
% mse_err2 = mse(TargetTestingPrimer', OutputTestingPrimer);
% rmse_err2 = sqrt(mse_err2);
% % figure, plotregression(TargetTestingPrimer', OutputTestingSekunder);
% performance_primer = perform(net,TargetTestingPrimer',OutputTestingPrimer);
% plot(1:30,OutputTestingPrimer,1:30,TargetTestingPrimer')

% %% Testing Data Primer
% 
% OutputTestingPengukuran = net(InputTestingPengukuran');
% mse_err2 = mse(TargetTestingPengukuran', OutputTestingPengukuran);
% rmse_err2 = sqrt(mse_err2);
% % figure, plotregression(TargetTestingPrimer', OutputTestingSekunder);
% performance_primer = perform(net,TargetTestingPengukuran',OutputTestingPengukuran);
% plot(1:30,OutputTestingPengukuran,1:30,TargetTestingPengukuran')
