%% PULIZIA MEMORIA E CHIUSURA FINESTRE

close all;
clear;
clc;

%% PARAMETRI SPETTRO

M = 2.5;                                        % Durata in secondi delle finestre da ascoltare 
Mxn = 1000;                                      % Durata in secondi del ruore bianco

finestra = 50;
lim = 5;    
offset = 5 * 10^-3;

finestra = finestra / M;

%% CARICAMENTO FILE AUDIO E SELEZIONE SINGOLO CANALE

Techno = 'audio/Techno.mp3';
Classica = 'audio/Classica.mp3';

[x1,Fs1] = audioread(Techno);
[x2,Fs2] = audioread(Classica);

Lxn = round(Mxn * Fs1);                         % Numero campioni di rumore bianco
xn = randn(Lxn,1);                              % Rumore bianco Gaussiano

x1 = x1(:,1);
x2 = x2(:,1);

%% 1 - DEFINIZIONE PORTA NEL DOMINIO DEL TEMPO

T_1 = 0.001;                                    % Durata porta in secondi PER TAGLIO AD 1 kHz
N = round(Fs1 * T_1);                           % Numero campioni

dt = 1 / Fs1;                                   % Intervallo di tempo tra campioni
p = ones(1,N);                                  % Porta di ampiezza 1 compsota da N campioni

t = 0:dt:(T_1 - dt);                            % Vettore tempo discreto causale
h1_filtro = p / N;                              % Effettuata normalizzazione la fine di evitare amplificazione del filtro

%% 2 - DEFINIZIONE COS RIALZATO NEL DOMINIO DEL TEMPO

T_2 = 0.0005;                                    
fr = 1/T_2;
banda = 1/(2*T_2);
beta = 0.001;

h2 = @(t) ...
    fr .* sinc(fr * t) .* (cos(pi*beta*t*fr) ./ (1 - (2*beta*t*fr).^2)) .* (t ~=  T_2/(2*beta) & t ~= -T_2/(2*beta)) + ...
    (pi/(4*T_2)) .* sinc(1/(2*beta)) .* (t ==  T_2/(2*beta)) + ...
    (pi/(4*T_2)) .* sinc(1/(2*beta)) .* (t == -T_2/(2*beta));

tempi = -(10*T_2):dt:(10*T_2);                   
h2_discreta = h2(tempi);
h2_filtro = h2_discreta / sum(h2_discreta);

%% 3 - DEFINIZIONE 1 - H(f) NEL DOMINIO DEL TEMPO

d_dirac = zeros(size(tempi));
[~, centro_idx] = max(h2_discreta);             % Trova l'indice del picco della sinc
d_dirac(centro_idx) = 1;
h3_filtro = d_dirac - h2_filtro;

%% PLOT FILTRI OTTENUTI - VERIFICA

% 1 - PORTA

fig1 = figure;
stem(t,h1_filtro);
xlabel('Tempo (s)')
ylabel('Ampiezza')
title('Filtro porta')

figure_name = sprintf('figure1.png');
print(fig1, figure_name, '-dpng', '-r600');

% 2 - COS RIALZATO

fig2 = figure;
stem(tempi + offset, h2_filtro);
xlabel('Tempo (s)')
ylabel('Ampiezza')
title('Filtro a coseno rialzato')

figure_name = sprintf('figure2.png');
print(fig2, figure_name, '-dpng', '-r600');

% 3 - 1 - H(f)

fig3 = figure;
stem(tempi + offset, h3_filtro);
xlabel('Tempo (s)')
ylabel('Ampiezza')
title('Filtro passa alto')

figure_name = sprintf('figure3.png');
print(fig3, figure_name, '-dpng', '-r600');


%% CALCOLO CONVOLUZIONI DEI BRANI CON I FILTRI

% 1 - PORTA

y1_conv_x1 = conv(x1, h1_filtro, 'same');          % 'same' usato per mantenere la stessa lunghezza del segnale in ingresso
y1_conv_x2 = conv(x2, h1_filtro, 'same');  

% 2 - COS RIALZATO

y2_conv_x1 = conv(x1, h2_filtro, 'same');        
y2_conv_x2 = conv(x2, h2_filtro, 'same'); 

% 3 - 1 - H(f)

y3_conv_x1 = conv(x1, h3_filtro, 'same');        
y3_conv_x2 = conv(x2, h3_filtro, 'same'); 

%% RITAGLIO FINESTRA INDICATA E CALCOLO SPETTRI

L = round(M * Fs1);                                 % Campioni per finestra
fin = (finestra - 1) * L + (1:L);

frequenze = (-L/2: L/2 - 1) .* (1/M) ./ 1000;       % Asse delle frequenze

fin_x1 = x1(fin);
fin_x2 = x2(fin);

y1_fin_x1 = y1_conv_x1(fin);   
y1_fin_x2 = y1_conv_x2(fin);

y2_fin_x1 = y2_conv_x1(fin);      
y2_fin_x2 = y2_conv_x2(fin);

y3_fin_x1 = y3_conv_x1(fin);      
y3_fin_x2 = y3_conv_x2(fin);

X1 = fft(fin_x1);
X2 = fft(fin_x2);

Y1X1 = fft(y1_fin_x1); 
Y1X2 = fft(y1_fin_x2);

Y2X1 = fft(y2_fin_x1); 
Y2X2 = fft(y2_fin_x2);

Y3X1 = fft(y3_fin_x1); 
Y3X2 = fft(y3_fin_x2);

%% PLOT SPETTRI IN-OUT BRANO 1

fig4 = figure;

subplot(4, 1, 1);

plot(frequenze, 20 * log10(fftshift(abs(X1).^2)), 'red');
xlim([-lim lim]);
disp(frequenze);
title('Spettro di energia del segnale in entrata non filtrato - Brano 1');
xlabel('kHz');
ylabel('dB');
grid on;

subplot(4, 1, 2);

plot(frequenze, 20 * log10(fftshift(abs(Y1X1).^2)), 'blue');
xlim([-lim lim]);
disp(frequenze);
title('Spettro di energia del segnale in uscita dal primo filtro - Brano 1');
xlabel('kHz');
ylabel('dB');
grid on;

subplot(4, 1, 3);

plot(frequenze, 20 * log10(fftshift(abs(Y2X1).^2)), 'blue');
xlim([-lim lim]);
disp(frequenze);
title('Spettro di energia del segnale in uscita dal secondo filtro - Brano 1');
xlabel('kHz');
ylabel('dB');
grid on;

subplot(4, 1, 4);

plot(frequenze, 20 * log10(fftshift(abs(Y3X1).^2)), 'blue');
xlim([-lim lim]);
disp(frequenze);
title('Spettro di energia del segnale in uscita dal terzo filtro - Brano 1');
xlabel('kHz');
ylabel('dB');
grid on;

figure_name = sprintf('figure4.png');
print(fig4, figure_name, '-dpng', '-r600');

%% PLOT SPETTRI IN-OUT BRANO 2

fig5 = figure;

subplot(4, 1, 1);

plot(frequenze, 20 * log10(fftshift(abs(X2).^2)), 'red');
xlim([-lim lim]);
disp(frequenze);
title('Spettro di energia del segnale in entrata non filtrato - Brano 2');
xlabel('kHz');
ylabel('dB');
grid on;

subplot(4, 1, 2);

plot(frequenze, 20 * log10(fftshift(abs(Y1X2).^2)), 'blue');
xlim([-lim lim]);
disp(frequenze);
title('Spettro di energia del segnale in uscita dal primo filtro - Brano 2');
xlabel('kHz');
ylabel('dB');
grid on;

subplot(4, 1, 3);

plot(frequenze, 20 * log10(fftshift(abs(Y2X2).^2)), 'blue');
xlim([-lim lim]);
disp(frequenze);
title('Spettro di energia del segnale in uscita dal secondo filtro - Brano 2');
xlabel('kHz');
ylabel('dB');
grid on;

subplot(4, 1, 4);

plot(frequenze, 20 * log10(fftshift(abs(Y3X2).^2)), 'blue');
xlim([-lim lim]);
disp(frequenze);
title('Spettro di energia segnale in uscita dal terzo filtro - Brano 2');
xlabel('kHz');
ylabel('dB');
grid on;

figure_name = sprintf('figure5.png');
print(fig5, figure_name, '-dpng', '-r600');

%% VERIFICA PRATICA BRANO 1

% 1 - PORTA

soundsc(fin_x1, Fs1);
pause(3)
soundsc(y1_fin_x1, Fs1);
pause(3)

% 2 - COS RIALZATO

soundsc(fin_x1, Fs1);
pause(3)
soundsc(y2_fin_x1, Fs1);
pause(3)

% 3 - 1 - H(f)

soundsc(fin_x1, Fs1);
pause(3)
soundsc(y3_fin_x1, Fs1);
pause(3)

%% VERIFICA PRATICA BRANO 2

% 1 - PORTA

soundsc(fin_x2, Fs1);
pause(3);
soundsc(y1_fin_x2, Fs1);
pause(3);

% 2 - COS RIALZATO

soundsc(fin_x2, Fs1);
pause(3);
soundsc(y2_fin_x2, Fs1);
pause(3);

% 3 - 1 - H(f)

soundsc(fin_x2, Fs1);
pause(3);
soundsc(y3_fin_x2, Fs1);
pause(3);


%% CALCOLO FUNZIONI DI TRASFERIMENTO TRAMITE RUMORE GAUSSIANO

XN = fft(xn);

Y1XN = fft(conv(xn, h1_filtro, 'same'));
Y2XN = fft(conv(xn, h2_filtro, 'same'));
Y3XN = fft(conv(xn, h3_filtro, 'same'));

H1 = Y1XN ./ XN;
H2 = Y2XN ./ XN;
H3 = Y3XN ./ XN;

frequenzexn = (-Lxn/2 : Lxn/2 - 1) .* (1/Mxn) ./ 1000;

fig6 = figure;

plot(frequenzexn, 20 * log10(abs(fftshift(H1))), 'black', 'LineWidth', 1.5);
xlim([-10 10]); 
title('Funzione di trasferimento (H1 = Y/X)');
xlabel('kHz');
ylabel('dB');
grid on;

figure_name = sprintf('figure6.png');
print(fig6, figure_name, '-dpng', '-r600');

fig7 = figure;

plot(frequenzexn, 20 * log10(abs(fftshift(H2))), 'black', 'LineWidth', 1.5);
xlim([-lim lim]); 
title('Funzione di trasferimento (H2 = Y/X)');
xlabel('kHz');
ylabel('dB');
grid on;

figure_name = sprintf('figure7.png');
print(fig7, figure_name, '-dpng', '-r600');

fig8 = figure;

plot(frequenzexn, 20 * log10(abs(fftshift(H3))), 'black', 'LineWidth', 1.5);
xlim([-lim lim]); 
title('Funzione di trasferimento (H3 = Y/X)');
xlabel('kHz');
ylabel('dB');
grid on;

figure_name = sprintf('figure8.png');
print(fig8, figure_name, '-dpng', '-r600');
