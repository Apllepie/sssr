% Stan robota przyjmujący wartości równe 1
q  = [1; 1; 1]; % położenia q1, q2, q3
dq = [1; 1; 1]; % prędkości dq1, dq2, dq3

% Parametry
l2 = 0.3; l3 = 0.2; m2 = 20; m3 = 20;
c3 = cos(q(3)); s3 = sin(q(3));
dq3 = dq(3);

% Wyznaczenie macierzy liczbowych
[M_val, C_val, D_val] = robot_matrices(q, dq);

% 3. Obliczenie dM/dt (pochodna M po czasie)
dM = zeros(3,3);
dM(1,1) = dq3 * m3 * (- (2/3)*l3^2*s3*c3 - l2*l3*s3);
dM(2,3) = dq3 * (-0.5 * m3 * l2 * l3 * s3);
dM(3,2) = dM(2,3);

disp('Macierz M:'); disp(M_val);
disp('Macierz C:'); disp(C_val);
disp('Wektor D:');  disp(D_val);

% 4. Wyznaczenie macierzy S = dM - 2*C
S = dM - 2*C_val;

% 5. Test skośnej symetrii: (S + S') powinno wynosić 0
%S_check = S + S';
S_check = dM - C_val - C_val';

disp('Macierz S = dM - 2*C:');
disp(S);

disp('Wynik S + S^T (powinien być macierzą zerową):');
disp(S_check);

if norm(S_check) < 1e-12
    disp('Weryfikacja udana: Macierz (dM - 2C) jest skośnosymetryczna!');
else
    disp('Macierz NIE jest skośnosymetryczna - sprawdź wzory.');
end