% Adam para o caso de sistema linear subdeterminado
clear all;
randn('state',0);
N = 10;
Nit = 500;
X = randn(N,2*N);
S = sign(randn(N,1));
w = (X'/(X*X'))*S;      % optimal solution
w1 = zeros(2*N,1);      % initial weights
%passo = 0.1;
passo = 0.001
%-----------------------------
% parameters
beta_1 = 0.9;
beta_2 = 0.999;
e = 1e-8;
m = v = m_hat = v_hat = zeros(2*N,1);
%-----------------------------
% loop
for it=2:Nit,
    g = X'*X*w1(:,it-1)-X'*S;
    m = beta_1*m + (1-beta_1)*g;
    v = beta_2*v + (1-beta_2)*g.^2;
    m_hat = m / (1 - beta_1^(it-1));
    v_hat = v / (1 - beta_2^(it-1));
    w1(:,it) = w1(:,it-1) - passo./(sqrt(v_hat) + e) .* m_hat;
    %w1(:,it) = w1(:,it-1) - (passo/sqrt(it))*(X'*X*w1(:,it-1)-X'*S);
end
%-----------------------------
% plot weights
figure(1);
title('Stochastic Gradient Descent');
for it = 1:(Nit-1),
    plot([w1(1,it);w1(1,it+1)],[w1(2,it);w1(2,it+1)]);hold on;
    plot(w1(1,it),w1(2,it),'o');
    plot(w1(1,it+1),w1(2,it+1),'o');
end
hold off;
disp('[Minimum Norm Solution Obtained solution]');
disp([w w1(:,Nit)]);
[S X*w X*w1(:,Nit)]
%-----------------------------
% save figure
path = strcat('../figures/Q1/adam_under_step_', num2str(passo), '.png');
saveas(gcf, path);
