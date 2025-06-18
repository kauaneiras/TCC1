% Controle por realimentação de estados
pC = (0.6)*ones(1,5);
pC(4) = 0.5 + 0.4*1i;
pC(5) = 0.5 - 0.4*1i;
n = 4;
m = 1;

Ahat = [A, B; zeros(1,n), 0];
Bhat = [zeros(n,1); eye(m)];
Khat = acker(Ahat, Bhat, pC);
K = (Khat + [zeros(m, n), eye(m)])/([A - eye(n), B; H*A, H*B]);
Ki = K(5);
Kp = K(1:4);