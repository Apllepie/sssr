function [M, C, D] = robot_matrices(q, dq)
    % Parametry modelu
    l2 = 0.3;   % [m]
    l3 = 0.2;   % [m]
    m2 = 20;    % [kg]
    m3 = 20;    % [kg]
    g  = 9.81;  % [m/s^2]

    % Zmienne trygonometryczne dla czytelności
    c3 = cos(q(3));
    s3 = sin(q(3));

    % Pomocniczy wyrażenie powtarzające się w macierzy Coriolisa
    h = 0.5 * m3 * l2 * l3 * s3 + (1/3) * m3 * l3^2 * s3 * c3;

    % Macierz bezwładności M(q)
    M = [ (1/3)*m2*l2^2 + m3*(l2^2 + (1/3)*l3^2*c3^2 + l2*l3*c3),  0,                             0;
          0,                                                      m2 + m3,                       0.5*m3*l2*l3*c3;
          0,                                                      0.5*m3*l2*l3*c3,               (1/3)*m3*l3^2 ];

    % Macierz Coriolisa C(q, dq)
    C = [ -dq(3) *h,  0,  -dq(1) * h;
          0,                                                 0,  -dq(3) * 0.5 * m3 * l2 * l3 * s3;
          dq(1) * h,                                         0,   0 ];

    % Wektor grawitacji D(q)
    D = [ 0;
          (m2 + m3) * g;
          0.5 * g * m3 * l3 * c3 ];
end