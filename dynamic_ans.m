% Warunki początkowe: [q1, q2, q3, dq1, dq2, dq3]
x0 = [0; 0; 0; 0; 0; 0]; 

% Sterowanie u = [u1; u2; u3] (np. brak sterowania zewnętrznego)
u = [0; 0; 0]; 

% Czas symulacji [s]
tspan = [0 5]; 

% Symulacja za pomocą ode45
[t, x] = ode45(@(t, x) robot_dynamics(t, x, u), tspan, x0);

% Wykres kątów/położeń w czasie
figure;
plot(t, x(:, 1:3), 'LineWidth', 1.5);
grid on;
xlabel('Czas [s]');
ylabel('Współrzędne uogólnione q');
legend('q_1', 'q_2', 'q_3');
title('Ruch robota');