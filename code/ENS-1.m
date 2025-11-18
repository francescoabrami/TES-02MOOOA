%% E 1

clear all
close all

n = [-15:15];
x = [zeros(1,15),0:10,zeros(1,5)];
figure(1)
stem(n,x,'LineWidth',2)
xlabel('$n$ ','Interpreter','latex','Fontsize',20)
ylabel('$x[n]$ ','Interpreter','latex','Fontsize',20)
grid on
set(gca,'fontsize',30)

%% E 1.a

n = [-15:15];
y = [zeros(1,31)];

for k = -5:10
    y(16 + k) = x(16 + k + 5);
end

stem(n,y,'LineWidth',2)
xlabel('$n$ ','Interpreter','latex','Fontsize',20)
ylabel('$y[n]$ ','Interpreter','latex','Fontsize',20)
grid on
set(gca,'fontsize',30)

%% E 1.b

n = [-15:15];
y = [zeros(1,31)];

for k = -5:10
    y(16 + k) = x(16 - k + 5);
end

stem(n,y,'LineWidth',2)
xlabel('$n$ ','Interpreter','latex','Fontsize',20)
ylabel('$y[n]$ ','Interpreter','latex','Fontsize',20)
grid on
set(gca,'fontsize',30)

%% E 1.c

n = [-15:15];
y = [zeros(1,31)];

for k = 0:5 
    y(16 + k) = x(16 + 2*k);
end

stem(n,y,'LineWidth',2)
xlabel('$n$ ','Interpreter','latex','Fontsize',20)
ylabel('$y[n]$ ','Interpreter','latex','Fontsize',20)
grid on
set(gca,'fontsize',30)

%% E 1.d

n = [-15:15];
x = [zeros(1,15),0:10,zeros(1,5)];

y_1 = [zeros(1,31)];
y_2 = [zeros(1,31)];
y_3 = [zeros(1,31)];

for k = -10:1 
    y_1(16 + k) = x(16 + k + 10);
end

for k = 0:10
    y_2(16 + k) = x(16 - k + 10);
end 

y_3(16) = 10;

hold on
stem(n,y_1,'LineWidth',2)
stem(n,y_2,'--','LineWidth',2)
stem(n,-y_3,'-.','LineWidth',2)
grid on
xlabel('$n$ ','Interpreter','latex','Fontsize',20)
ylabel('$y_4[n]$ ','Interpreter','latex','Fontsize',20)

%% E 1.e


%% E 2

n = [-6:6];

x_1 = [zeros(1,3),1,2,1,zeros(1,1)];
x_2 = [zeros(1,3),3,2,1,zeros(1,1)];

z = conv(x_1, x_2);

stem(n,z,'LineWidth',2)

