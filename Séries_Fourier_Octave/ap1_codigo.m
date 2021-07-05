% Script: Aplica��o das S�ries de Fourier
% autor: Diego Ferruzzo
% data: Novembro, 2019.
% -------------------------------------------------------------------------
clear;
close all;
clc;
# 
# parametros do sistema LCIT
R = 5000;  % valor da resistencia
C = 10e-6; % valor da capacitancia
Th = 0.4;  % tempo em nivel alto
T0 = 1;     % valor do período do sinal de entrada
A = 1;     % amplitude do sinal de entrada
w0 = 2*pi/T0; % frequencia angular
j=sqrt(-1); # Não precisa

# A Reposta em frequência
Hi = @(w) j.*w.*C./(1+j.*w.*R.*C);  # para a corrente no circuito

# coeficientes das SF 
#
# para vs
# ======= 
# a SF complexa
X0 = A*Th/T0;  
Xk =@(k) A.*sin(k.*pi.*Th./T0).*exp(-j.*k.*pi.*Th./T0)./(pi.*k);
# a SF trigonométrica
a0 = X0;
ak =@(k) 2*real(Xk(k));
bk =@(k) -2*imag(Xk(k));
# a SF compacta
c0  = X0;
ck  =@(k) 2*sqrt((real(Xk(k))).^2 + (imag(Xk(k))).^2);
thk =@(k) angle(Xk(k));
#
# para i(t)
# =========
# a SF complexa
X0_til = 0;
Xk_til =@(k) Xk(k).*Hi(k.*w0);
# a SF trigonométrica
a0_til = X0_til;
ak_til =@(k) 2*real(Xk_til(k));
bk_til =@(k) -2*imag(Xk_til(k));
# a SF compacta
c0_til  = X0_til;
ck_til  =@(k) 2*sqrt((real(Xk_til(k))).^2 + (imag(Xk_til(k))).^2);
thk_til =@(k) angle(Xk_til(k));

# base de tempo
t = linspace(0,2,1000)';
# os vetores para os sinais
vs = zeros(1,length(t));  # tensão de entrada vs(t)
it = zeros(1, length(t));  # corrente no circuito i(t)

vs = a0;      # Adicionamos o termo constante para vs(t)
it = a0_til;  # Adicionamos o termo constante para i(t)

# numero de termos para os sinais
N = 8000;
for k = 1:N
    # para vs(t)
    vs = vs + ak(k)*cos(k*w0.*t)+bk(k)*sin(k*w0.*t);    
    # para i(t)
    it = it + ak_til(k)*cos(k*w0.*t)+bk_til(k)*sin(k*w0.*t);    
end
#
# Os gráficos dos espectros de amplitude e fase dos sinais
K = 20;   # numero de termos do espectro
ks = 1:K; # indice dos termos
#
# figuras
figure(1);clf;
[ax, h1, h2] = plotyy(t,vs, t,it);
grid on;
xlabel ('tempo');
ylabel (ax(1), 'v_s(t)');
ylabel (ax(2), 'i(t)');
set(ax(1), 'fontsize', 14, 'linewidth', 2);
set(ax(2), 'fontsize', 14, 'linewidth', 2);
set(ax(2),'yticklabel', {'-2e-4','-1e-4','0','1e-4','2e-4'});
set(h1, 'linewidth', 2);
set(h2, 'linewidth', 2);
#
figure(3);clf;
subplot(2,1,1);
title('Espectros de amplitude e fase');
[ax4, h41, h42] = plotyy([0 ks],[c0 ck(ks)],[0 ks],[c0_til ck_til(ks)],@stem,@stem);
xlabel('kw0');
grid on;
title('Espectro de Magnitude'); 
ylabel(ax4(1), 'v_s');
ylabel(ax4(2), 'i');
leg31 = legend('v_s','i');
set(h41, 'linewidth', 2,'color','b','markerfacecolor','b','markeredgecolor','b');
set(h42, 'linewidth', 2,'color','r','markerfacecolor','r','markeredgecolor','r');
set(leg31, 'fontsize', 14);
set(ax4, 'fontsize', 14);
#
subplot(2,1,2);
stem([0 ks],[0 thk(ks)],'linewidth',2,'color','b','markerfacecolor','b','markeredgecolor','b');     % A fase do espectro em freq. do sinal vi(t)
hold on;
stem([0 ks],[0 thk_til(ks)],'linewidth',2,'color','r','markerfacecolor','r','markeredgecolor','r'); % A fase do espectro em freq. do sinal vo(t)
xlabel('kw0');
grid on;
title('Espectro de Fase');
leg32 = legend('v_s','i');
set(leg32, 'fontsize', 14);
set(gca, 'fontsize', 14);
set(gca, 'ylim', [-pi 1]);
set(gca, 'ytick', [-pi 0 1]);
set(gca, 'yticklabel', {'-pi','0','1'});