%% GRADINO

n = [-10:10];
y = zeros(1,21);
y(11:21) = 1;
figure
set(gca,'FontSize',14)
stem(n,y,'k')
xlabel('n')
title('u(n)')
axis([-10 10 -0.5 1.5])
grid on

%% DELTA

n = [-10:10];
y = zeros(1,21);
y(11) = 1;
figure
set(gca,'FontSize',14)
stem(n,y,'k')
xlabel('n')
title('\delta(n)')
axis([-10 10 -0.5 1.5])
grid off

%% SINC n/3

n = [-10:10];
y = sinc(n/3);
figure
set(gca,'FontSize',14)
stem(n,y,'k')
xlabel('n')
title('sinc(n/3)')
axis([-10 10 -0.5 1.5])
grid on

%% PORTA

n = [-10:10];
y = zeros(1,21);
y(6:16) = 1;
figure
set(gca,'FontSize',14)
stem(n,y,'k')
xlabel('n')
title('p_{11}(n)')
axis([-10 10 -0.5 1.5])
grid on

%% TRIANGOLO

N = 10;
n = [-N:N];
y = 1 - abs(n)/N;
figure
set(gca,'FontSize',14)
stem(n,y,'k')
xlabel('n')
title('t_{21}(n)')
axis([-10 10 -0.5 1.5])
grid on

%% ESPONENZIALE

n = [-10:10];
a = (2/3);
y = a.^n.*(n >= 0);
figure
set(gca,'FontSize',14)
stem(n,y,'k')
xlabel('n')
title('(2/3)^n')
axis([-10 10 -0.5 1.5])
grid on

%% GAUSSIAN RANDOM WALKS

N = 10^6;      
numWalks = 200; 
sigma = 1;

steps = sigma * randn(N, numWalks);  
walks = cumsum(steps);              

fig = figure;
plot(walks, 'LineWidth', 0.1);
grid on;

xlabel('Passi');
ylabel('Posizioni');
title(sprintf('Gaussian Random Walks'));

figure_name = sprintf("GRW.png");
print(fig, figure_name, '-dpng', '-r300');

%%





