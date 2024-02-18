% Definir probabilidades de generar 1 y 0
P_B1 = 0.9; % Por ejemplo
P_B2 = 1 - P_B1;

% Generar secuencia de bits
num_bits = 10000;
bits = rand(1, num_bits) < P_B1;

% Definir probabilidad de error del canal simétrico binario
p_error = 0.1; % Por ejemplo

% Aplicar el canal simétrico binario
received_bits = xor(bits, rand(1, num_bits) < p_error);

% Calcular las probabilidades P(A1) y P(A2) en el receptor
P_A1 = sum(received_bits) / num_bits;
P_A2 = 1 - P_A1;

% Calcular las probabilidades condicionales inversas
P_B1_given_A1 = sum(bits & received_bits) / sum(received_bits);
P_B2_given_A2 = sum(~bits & ~received_bits) / sum(~received_bits);

% Calcular las probabilidades condicionales inversas adicionales
P_B1_given_A2 = sum(bits & ~received_bits) / sum(~received_bits);
P_B2_given_A2 = sum(~bits & received_bits) / sum(received_bits);

% Calcular todas las probabilidades a priori por conteo
P_B1_count = sum(bits) / num_bits;
P_B2_count = 1 - P_B1_count;

% Calcular todas las probabilidades a posteriori por conteo
P_A1_given_B1_count = sum(received_bits & bits) / sum(bits);
P_A2_given_B1_count = 1 - P_A1_given_B1_count;
P_A1_given_B2_count = sum(~received_bits & ~bits) / sum(~bits);
P_A2_given_B2_count = 1 - P_A1_given_B2_count;

% Crear tabla comparativa
fprintf('Comparación de resultados teóricos y prácticos:\n');
fprintf('----------------------------------------------\n');
fprintf('            Teórico     |   Práctico\n');
fprintf('----------------------------------------------\n');
fprintf('P(B1)       %.4f       |   %.4f\n', P_B1, P_B1_count);
fprintf('P(B2)       %.4f       |   %.4f\n', P_B2, P_B2_count);
fprintf('P(A1|B1)    %.4f       |   %.4f\n', P_B1 * (1 - p_error), P_A1_given_B1_count);
fprintf('P(A2|B1)    %.4f       |   %.4f\n', P_B1 * p_error, P_A2_given_B1_count);
fprintf('P(A1|B2)    %.4f       |   %.4f\n', P_B2 * p_error, P_A1_given_B2_count);
fprintf('P(A2|B2)    %.4f       |   %.4f\n', P_B2 * (1 - p_error), P_A2_given_B2_count);
fprintf('P(A1)       %.4f       |   %.4f\n', P_A1, P_A1);
fprintf('P(A2)       %.4f       |   %.4f\n', P_A2, P_A2);
fprintf('----------------------------------------------\n');
