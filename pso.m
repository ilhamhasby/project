% Mendefinisikan objektif function atau cost function
function [x,predict] = pso(CostFunction,nVar)

%% Range Jawaban
VarSize = [1 nVar];
% jumlah variable
VarMin = -5;
VarMax = 5;
MaxIt = 1000; % Iterasi
nPop = 70; %Jumlah Populasi

% PSO Parameter
w = 1;
wdamp = 0.99; % weight
c1 = 1.2; % konstanta akselerasi
c2 = 1.2;

% Batas Kecepatan
VelMax = 0.1* (VarMax-VarMin);
VelMin = -VelMax;

% Inisialisasi
empty_particle.Position=[];
empty_particle.Cost=[];
empty_particle.Velocity=[];
empty_particle.Best.Position=[];
empty_particle.Best.Cost=[];

particle = repmat(empty_particle, nPop, 1);

GlobalBest.Cost = inf;

for i = 1:nPop 
    
    % Inisialisasi Posisi
    particle(i).Position = unifrnd(VarMin, VarMax, VarSize);
    % Inisialisasi Kecepatan
    particle(i).Velocity = zeros(VarSize);
    % Evaluasi
    particle(i).Cost = CostFunction(particle (1).Position);
    % Perbarui posisi Terbaik
    particle(i).Best.Position = particle(i).Position;
    particle(i).Best.Cost = particle(i).Cost;
    % Perbarui cost Terbaik
    if particle(i).Best.Cost < GlobalBest.Cost
        
        GlobalBest = particle(1).Best;
    
    end
    
end

BestCost = zeros(MaxIt,1);


%% PSO Main Loop

for it = 1:MaxIt
    
    for i = 1:nPop
        
    % Perbarui Kecepatan
    particle(1).Velocity = w*particle(i).Velocity + c1*rand(VarSize).*(particle(i).Best.Position-particle(i).Position) + c2*rand(VarSize).*(GlobalBest.Position-particle(i).Position);
    
    % Terapkan Batas Kecepatan
    particle(i).Velocity = max(particle(i).Velocity,VelMin);
    particle(i). Velocity = min(particle(i).Velocity,VelMax);
    
    % Perbarui posisi
    particle(i).Position = particle(i).Position + particle(i).Velocity;
    
    % Efek Cermin Kecepatan
    IsOutside = (particle(i).Position < VarMin | particle(i).Position > VarMax);
    particle(i).Velocity(IsOutside) = -particle(1).Velocity(IsOutside);
    
    % Terapkan Batas Posisi
    particle(i).Position = max(particle(i).Position,VarMin);
    particle(i).Position = min(particle(i).Position,VarMax);
    
    % Evaluasi
    particle(i).Cost = CostFunction(particle(i).Position);
    
    % Perbarui Pribadi Terbaik
    if particle(i).Cost < particle(i).Best.Cost
        
        particle(i).Beat.Position = particle(i).Position;
        particle(i).Best.Cost = particle(i).Cost;
        
        % Perbarui Terbaik Global
        if particle(i).Best.Cost < GlobalBest.Cost
            
            GlobalBest = particle(i).Best;
            
        end
        
    end
   
end

BestCost(it) = GlobalBest.Cost;

disp(['Iterasi' num2str(it) ': Fitness Value (NMSE) =' num2str(BestCost(it))]);

w = w*wdamp;

end

BestSol = GlobalBest;
x = BestSol.Position';
predict = BestSol.Cost;


%% Hasil

figure;
% plot (BestCost, 'LineWidth', 2);
semilogy(BestCost,'LineWidth',2);
xlabel('Iterasi');
ylabel('Fitness Value (NMSE)');
grid on;


