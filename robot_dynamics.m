function dxdt = robot_dynamics(t, x, u)
    % x(1:3) -> q (położenia)
    % x(4:6) -> dq (prędkości)
    q  = x(1:3);
    dq = x(4:6);

    % Pobranie macierzy dynamiki
    [M, C, D] = robot_matrices(q, dq);

    % Obliczenie przyspieszeń: ddq = M \ (u - C*dq - D)
    ddq = M \ (u - C*dq - D);

    % Pochodna stanu: [dq; ddq]
    dxdt = [dq; ddq];
end