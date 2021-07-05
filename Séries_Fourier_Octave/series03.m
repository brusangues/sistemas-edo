clear all
close all
clc
# Os parâmetros do exemplo Ts/T0 = 4
Ts = 2;
T0 = 5;       # O o período
w0 = 2*pi/T0; # a frequência angular

# Definimos um vetor tempo
t = -T0:0.01:T0;   # queremos visualizar dois períodos, de -T0 até T0

# A Série Complexa
X0 = 2.*Ts/T0;
Xk = @(k) ( exp(j.*k.*2.*pi.*t./5).*(1-exp(-j.*k.*4.*pi./5))./(j.*k.*pi) );

# Definimos o sinal x(t) do mesmo tamanho do vetor tempo
x3 = zeros(1, length(t)); # para a série complexa

# adicionamos o temo constante no início de cada série
x3 = X0;
N = 500;

# para a série complexa fazemos
M = [[-N:-1] [1:N]];
for r=1:length(M)
  k = M(r);  
  x3 = x3 + Xk(k).*exp(j.*k.*w0.*t);
endfor

# Geramos a figura para a série compleja
figure(3);
plot(t, x3, 'linewidth', 2);
grid on;
xlabel('tempo');
ylabel('x(t)');
l1 = legend('x(t)');
set(l1, 'fontsize', 14);
title(strcat('(Complexa) x(t) para N=',num2str(N)));
set(gca, 'fontsize', 14);