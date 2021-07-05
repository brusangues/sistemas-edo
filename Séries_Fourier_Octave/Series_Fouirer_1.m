clear all
close all
clc
# Os parâmetros do exemplo Ts/T0 = 4
Ts = 1;
T0 = 4;       # O o período
w0 = 2*pi/T0; # a frequência angular

# Definimos um vetor tempo
t = -T0:0.01:T0;   # queremos visualizar dois períodos, de -T0 até T0

# A Série Trigonométrica
a0 = 2*Ts/T0; # o coeficiente a0
ak =@(k) (2./(k.*pi)).*sin(k.*pi./2);  # o coeficientes como função de k
bk =@(k) 0;

# A Série Compacta
c0  = a0;                               # o coeficiente c0
ck  =@(k) abs(ak(k));    # o coeficente ck
thk =@(k) -atan2(bk(k), ak(k));         # o ângulo theta(k)

# A Série Complexa
###X0 = c0;
###Xk =@(k) (1/2).*(ak(k)-j.*bk(k));
###X0 = 1./2;
###Xk = @(k) ( ( 1./(k.*pi) ).*sin(k.*pi./2).*exp(j.*k.*t.*pi./2) );
X0 = 1./2;
Xk = @(k) ( ak(k) );



# Definimos o sinal x(t) do mesmo tamanho do vetor tempo
x1 = zeros(1, length(t)); # para a série trigonométrica  
x2 = zeros(1, length(t)); # para a série compacta
x3 = zeros(1, length(t)); # para a série complexa

# adicionamos o temo constante no início de cada série
x1 = a0;
x2 = c0;
x3 = X0;

N = 500;      # o número de termos da série de Fourier (voce pode mudar isso a vontade)

# Adicionamos os N termos na série trigonométrica e compacta
for k=1:N
  x1 = x1 + ak(k)*cos(k*w0.*t) + bk(k)*sin(k*w0.*t);  # SF trigonométrica
  x2 = x2 + ck(k)*cos(k*w0.*t + thk(k));              # SF compacta
endfor

# para a série complexa fazemos
M = [[-N:-1] [1:N]];
for r=1:length(M)
  k = M(r);  
  x3 = x3 + Xk(k).*exp(j.*k.*w0.*t);
endfor

# Geramos a figura para a série trigonométrica
figure(1);
plot(t, x1, 'linewidth', 2);
grid on;
xlabel('tempo');
ylabel('x(t)');
l1 = legend('x(t)');
set(l1, 'fontsize', 14);
title(strcat('(Trigonométrica) x(t) para N=',num2str(N)));
set(gca, 'fontsize', 14);

# Geramos a figura para a série compacta
figure(2);
plot(t, x2, 'linewidth', 2);
grid on;
xlabel('tempo');
ylabel('x(t)');
l1 = legend('x(t)');
set(l1, 'fontsize', 14);
title(strcat('(Compacta) x(t) para N=',num2str(N)));
set(gca, 'fontsize', 14);

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

# Os gráficos das amplitudes e fases
ks = 1:70; # iremos considerar ks termos

figure(4);
subplot(2,1,1);
stem([0 ks], [c0 ck(ks)], 'linewidth', 2);
grid on;
xlabel('k');
l21 = legend('c_k(k)');
set(l21, 'fontsize', 14);
title('Espectro de amplitude');
set(gca, 'fontsize', 14);

subplot(2,1,2);
stem([0 ks], [0 thk(ks)], 'linewidth', 2);
grid on;
xlabel('k');
title('Espectro de fase');
l22 = legend('theta_k(k)');
set(l22, 'fontsize', 14);
set(gca, 'ylim', [-pi 0]);
set(gca, 'ytick', [-pi -pi/2 0]);
set(gca, 'yticklabel', {'-pi','-pi/2','0'});
set(gca, 'fontsize', 14);



