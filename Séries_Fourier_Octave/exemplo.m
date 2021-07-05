# data: 23/06/2021
# autor: Diego Ferruzzo
# =====================
# Exemplo do resumo das Séries de Fourier
# =======================================
clear all
close all
clc
# parâmetros
T0 = pi;
w0 = 2*pi/T0;
# A série complexa
X0 = 2*(1-exp(-pi/2))/pi;
Xk =@(k) (2*(1-exp(-pi/2)).*(1-j*4.*k))./(pi*(1 + 16.*k.^2));
# A série trigonométrica
a0 = X0;
ak =@(k) 2*real(Xk(k));
bk =@(k) -2*imag(Xk(k));
# A série compacta
c0  = X0;
ck  =@(k) 2*sqrt((real(Xk(k))).^2+(imag(Xk(k))).^2);
thk =@(k) angle(Xk(k));

# os gráficos
# ===========
# definimos uma base de tempo
t = -2*T0:0.01:2*T0;
# definimos vários N
N = [10 50 500 5000];
x = zeros(length(N), length(t));
# para as séries trigonométrica e compacta
x(:,:) = X0; # a0, c0
#for r=1:length(N)
#  for k=1:N(r)
    # a SF trigonométrica
    #x(r,:) = x(r,:) + ak(k)*cos(k*w0.*t) + bk(k)*sin(k*w0.*t);
    # a SF compacta
#    x(r, :) = x(r, :) + ck(k)*cos(k*w0.*t + thk(k));
#   endfor
#endfor 
#
# para a série complexa
#x(:,:) = X0;
for r=1:length(N)
  M = [[-N(r):-1] [1:N(r)]];
  for s=1:length(M)
    k = M(s);
    x(r,:) = x(r,:) + Xk(k)*exp(j*k*w0.*t);
   endfor
endfor 
#    
figure(1);
for i=1:length(N)
  subplot(2,2,i);
  plot(t, x(i,:), 'linewidth',2);
  grid on;
  title(strcat('N = ',num2str(N(i))));
  xlabel('tempo');
  ylabel('x(t)');
  ylim([0 1.2]);
  xlim([-pi pi]);
  xticks([-pi 0 pi]);
  xticklabels({'-pi', '0', 'pi'});
  set(gca, 'fontsize', 14);
endfor
#
# Os espectros de magnitude e fase
K = 20; # número de harmônicos
ks = 1:20;
figure(2);
subplot(2,1,1);
stem([0 ks], [c0 ck(ks)], 'linewidth', 2);
grid on;
xlabel('k');
title('Espectro de amplitude');
set(gca, 'fontsize', 14);

subplot(2,1,2);
stem([0 ks], [0 thk(ks)], 'linewidth', 2);
grid on;
xlabel('k');
title('Espectro de fase');
ylim([-pi/2 0]);
yticks([-pi/2 -pi/4 0]);
yticklabels({'-pi/2','-pi/4','0'});
set(gca, 'fontsize', 14);



    
