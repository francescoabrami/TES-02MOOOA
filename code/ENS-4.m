%% ESERCITAZIONE ENS - 4

%% ES 4

fig2 = figure;
lim = 1.2;
x = 0;
y = 0;

% zeros = [1 1 -2]; 
% poles = [0.25 0];

poles = [1 0.556 0.81]; 
zeros = [1 2.022 1.5625];    

plot(real(zeros), imag(zeros), 'o', 'MarkerSize', 10, 'LineWidth', 2, 'Color', 'b');
ylim([-lim lim]);
hold on;

plot(real(poles), imag(poles), 'x', 'MarkerSize', 12, 'LineWidth', 2, 'Color', 'r');

theta = linspace(0, 2*pi, 100);
plot(cos(theta), sin(theta), '--k', 'LineWidth', 1.5);
ylim([-lim lim]);

axis equal;
grid on;
xlabel('Re');
ylabel('Im');
title('Poli e Zeri');
legend('Zeros', 'Poles');

figure_name = sprintf("IMAGE.png");
print(fig2, figure_name, '-dpng', '-r300');

%%
B = [1 0.556 0.81];      % zeros
A = [1 2.022 1.5625];    % poles

zplane(B, A);
grid on;
title('Poli e Zeri del sistema');

%%

fig2 = figure;
lim = 1.2;
x = 0;
y = 0;

A = [1 1 -2];
B = [1 -0.25 0]; 

% Compute zeros and poles (optional, already in polynomial form)
zeros_system = roots(B);
poles_system = roots(A);

% Plot zeros
plot(real(zeros_system), imag(zeros_system), 'o', ...
    'MarkerSize', 12, 'LineWidth', 3, 'Color', 'b'); 
ylim([-lim lim]);
hold on;

% Plot poles
plot(real(poles_system), imag(poles_system), 'x', ...
    'MarkerSize', 12, 'LineWidth', 3, 'Color', 'r');
ylim([-lim lim]);

% Plot unit circle
theta = linspace(0, 2*pi, 200);
plot(cos(theta), sin(theta), '--k', 'LineWidth', 2);
ylim([-lim lim]);

% Formatting
axis equal;
grid on;
xlabel('Re');
ylabel('Im');
title('Poli e Zeri');
legend('Zeri', 'Poli');

figure_name = sprintf("IMAGE.png");
print(fig2, figure_name, '-dpng', '-r300');

%%

clear;
close all;
clc;
