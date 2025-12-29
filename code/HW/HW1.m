%% PULIZIA MEMORIA E CHIUSURA FINESTRE
close all;
clear;
clc;

%% CARICAMENTO FILE AUDIO E SELEZIONE SINGOLO CANALE

Techno = '../audio/Techno.mp3';
Classica = '../audio/Classica.mp3';

[x_1,Fs_1] = audioread(Techno);
[x_2,Fs_2] = audioread(Classica);

x_1 = x_1(:,1);
x_2 = x_2(:,1);

%% PARAMETRI

M = 1;
finestra = 10;
lim = 1;

finestra = finestra / M;

%% CALCOLO LUNGHEZZA FINESTRE

Ntot_1 = length(x_1);
L_1 = round(M * Fs_1);
Nfin_1 = floor(Ntot_1 / L_1);

Ntot_2 = length(x_2);
L_2 = round(M * Fs_2);
Nfin_2 = floor(Ntot_2 / L_2);

fprintf(" - Brano 1 Finestra %d di %d \n", finestra, Ntot_1);
fin_1 = (finestra - 1) * L_1 + (1:L_1);
xfin_1 = x_1(fin_1);

fprintf(" - Brano 2 Finestra %d di %d \n", finestra, Ntot_2);
fin_2 = (finestra - 1) * L_2 + (1:L_2);
xfin_2 = x_2(fin_2);

f_1 = (-L_1/2: L_1/2 - 1) .* (1/M) ./ 1000;
f_2 = (-L_2/2: L_2/2 - 1) .* (1/M) ./ 1000;

%% VERIFICA PRATICA

sound(xfin_2, Fs_2)
pause(1);
sound(xfin_1, Fs_1)

%% CALCOLO FFT E DFT 

X_1_FFT = fft(xfin_1);
X_2_FFT = fft(xfin_2);

X_1_DFT = zeros(L_1,1);
n = 0:L_1 - 1;

for k = 0:L_1 - 1

    X_1_DFT(k+1) = sum(xfin_1.' .* exp(-1j * 2*pi * k * n / L_1));

end

X_2_DFT = zeros(L_2,1);
n = 0:L_2 - 1;

for k = 0:L_2 - 1

    X_2_DFT(k+1) = sum(xfin_2.' .* exp(-1j * 2*pi * k * n / L_2));

end

%% CALCOLO SPETTRO ENERGIA

E_1_FFT = (abs(X_1_FFT)).^2;
E_2_FFT = (abs(X_2_FFT)).^2;

E_1_DFT = (abs(X_1_DFT)).^2;
E_2_DFT = (abs(X_2_DFT)).^2;

%% PLOT RISULTATI DFT

fig1 = figure;
subplot(2, 1, 1);
plot(f_1,20 * log10(fftshift(E_1_DFT)), 'red');
% xlim([-lim lim]);
disp(f_1);
title(['DFT - Finestra ', num2str(finestra),' di ' num2str(Nfin_1)]);
xlabel('kHz');
ylabel('dB');
grid on;

subplot(2, 1, 2);
plot(f_2,20 * log10(fftshift(E_2_DFT)), 'blue');
% xlim([-lim lim]);
disp(f_2);
title(['DFT - Finestra ', num2str(finestra),' di ' num2str(Nfin_2)]);
xlabel('kHz');
ylabel('dB');
grid on;

% figure_name = sprintf('F-%dDFT-M%.2f.png', finestra, M);
% print(fig1, figure_name, '-dpng', '-r600');

%% PLOT RISULTATI FFT

fig2 = figure;
subplot(2, 1, 1);
plot(f_1,20 * log10(fftshift(E_1_FFT)), 'red');
% xlim([-lim lim]);
disp(f_1);
title(['FFT - Finestra ', num2str(finestra),' di ' num2str(Nfin_1)]);
xlabel('kHz');
ylabel('dB');
grid on;

subplot(2, 1, 2);
plot(f_2,20 * log10(fftshift(E_2_FFT)), 'blue');
% xlim([-lim lim]);
disp(f_2);
title(['FFT - Finestra ', num2str(finestra),' di ' num2str(Nfin_2)]);
xlabel('kHz');
ylabel('dB');
grid on;

% figure_name = sprintf('F-%dFFT-M%.2f.png', finestra, M);
% print(fig2, figure_name, '-dpng', '-r600');










