%-------------------------------------------------------
% Teste de variação de pesos do controlador LQR
% Autor: Christian Danner Ramos de Carvalho
%-------------------------------------------------------

close all
clear
clc

% Definindo o modelo do sistema
A = [0 1; -1 -1];
B = [0; 1];
C = [1 0; 0 1];
D = 0;
sys = ss(A,B,C,D);

% Definindo os possíveis valores para Q e R
q_values = logspace(-2, 2, 5);
r_values = logspace(-2, 2, 5);

% Inicializando as matrizes de ganho
Ks = cell(length(q_values), length(r_values));

% Janela para plot
figure();
subplot(2,1,1);
title('Variando pesos do LQR');
xlabel('Tempo');
ylabel('Saída 1');
% legend();
grid;
hold on;

subplot(2,1,2);
xlabel('Tempo');
ylabel('Saída 2');
% legend();
grid;
hold on;

% Loop para variação dos valores de Q e R
for i = 1:length(q_values)
    for j = 1:length(r_values)
        % Calculando o ganho do controlador LQR
        Q = q_values(i)*eye(2);
        R = r_values(j)*eye(1);
        [K,~,~] = lqr(A,B,Q,R);
        Ks{i,j} = K;
        
        % Simulando o sistema com o controlador LQR
        sys_cl = ss(A-B*K, B, C, D);
        t = 0:0.01:10;
        u = zeros(size(t));
        x0 = [1; 0];
        [y,t,x] = lsim(sys_cl, u, t, x0);
        
        % Plotando as saídas
%         figure(i*j);
        subplot(2,1,1);
        plot(t, y(:,1));
%         legend(['Q = ', num2str(q_values(i)), ', R = ', num2str(r_values(j))])
        
%         xlabel('Tempo');
%         ylabel('Saída 1');
%         title(['LQR com Q = ', num2str(q_values(i)), ', R = ', num2str(r_values(j))]);
        

        subplot(2,1,2);
        plot(t, y(:,2));
%         legend(['Q = ', num2str(q_values(i)), ', R = ', num2str(r_values(j))])
%         xlabel('Tempo');
%         ylabel('Saída 2');
%         legend();
%         grid;
%         hold on;
    end
end
