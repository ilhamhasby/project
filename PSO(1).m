clear all
clc

%min max
limit= [-5 5]; % range jawaban
jum_pop=20;    % jumlah populasi
var=2;         % jumlah variable

% parameter pso
w_max=0.9       % weight
w_min=0.4
c1=1.2;          % konstanta akselerasi
c2=1.2;
iter=1;
iter_max=10;

for it=1:iter_max %bias weight
    w(it)=w_max-((w_max-w_min)/iter_max)*it;
end

for i=1:jum_pop  % baris - jumlah popuasi
    for j=1:var  % kolom - jumlah variable
        position(i,j)= (limit(2)-limit(1))*rand + limit(1);    %population
    end
end
clear i j
 position_awal = position;
 
for i=1:jum_pop  
    for j=1:var  
        velocity(i,j)=0;
    end
end
clear i j
velocity

%y=(x1-1)^2 + (x2+1)^2;
for i=1:jum_pop  % baris - jumlah popuasi
   
   fitness(i)=((position(i,2)-position(i,1))^2)^2 + ((position(i,1)-1)-1)^2;  % fitness  %y=(x1-1)^2 + (x2+1)^2;

end
clear i j

[fitness_best, indek]=min(fitness); % dicari nilai minimum dari fitness, dan lokasi 
Fgbest=fitness_best;
pbest=position(indek,:); % posisi terbaik pada baris(indek), diambil semua sepaket
pgbest=pbest;
Fbest(1)=Fgbest;

for i=1:jum_pop  
    % for j=1:var  
        velocity(i,:)= w(1)*velocity(i,:) + c1*rand*(pbest-position(i,:))+ c2*rand*(pgbest-position(i,:));
    % end
end

position=position+velocity
%masuk iterasi

while iter < iter_max
    iter=iter+1
    
    for ii=1:jum_pop
        for jj=1:var
           if position(ii,jj) < limit(1)
               position(ii,jj)= limit(1);
           elseif position(ii,jj)> limit(2)
               position(ii,jj)= limit(2);
           end
           % stop(t);
        end
    end
    
    for i=1:jum_pop  % baris - jumlah popuasi
        fitness(i)=((position(i,2)-position(i,1))^2)^2 + ((position(i,1)-1)-1)^2;
    end

    clear i j

    [fitness_best, indek]=min(fitness); % dicari nilai minimum dari fitness, dan lokasi 

    pbest=position(indek,:); % posisi terbaik pada baris(indek), diambil semua sepaket

    if fitness_best < Fgbest  
        pgbest=pbest;
        Fgbest=fitness_best
    end

    Fbest(iter)=Fgbest;
 
    for i=1:jum_pop  
    % for j=1:var  
        velocity(i,:)= w(it)*velocity(i,:) + c1*rand*(pbest-position(i,:))+ c2*rand*(pgbest-position(i,:));
    % end
    end
    
     velocity=velocity
     position=position+velocity
 %Fgbest
end

plot(Fbest)
    