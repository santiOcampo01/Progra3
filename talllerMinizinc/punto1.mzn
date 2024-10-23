% Paso 1
int: num_disciplinas = 4;
int: num_participantes = 6;
int: num_lugares = 2;

% Paso 1 y 2
array[1..num_disciplinas] of var 1..num_participantes: participante;
array[1..num_disciplinas] of var 1..num_lugares: lugar;

% Paso 3
array[1..num_disciplinas] of int: duraciones = [2, 3, 1, 2];

% Horarios de inicio
array[1..num_disciplinas] of var 1..10: horario;

% Paso 4
constraint forall(p in 1..num_participantes)(
  sum([if participante[i] = p then 1 else 0 endif | i in 1..num_disciplinas]) <= 1
);

% Paso 5
constraint forall(i, j in 1..num_disciplinas where i != j)(
    lugar[i] = lugar[j] -> (horario[i] + duraciones[i] <= horario[j] \/ horario[j] + duraciones[j] <= horario[i])
);

% Paso 6
constraint forall(p in 1..num_participantes, i, j in 1..num_disciplinas where i != j)(
    participante[i] = p /\ participante[j] = p -> (horario[i] + duraciones[i] <= horario[j] \/ horario[j] + duraciones[j] <= horario[i])
);

% Paso 7
array[1..num_lugares] of int: num_horas_lugar = [5, 6];  
% Paso 8
constraint forall(l in 1..num_lugares)(
    sum([duraciones[i] | i in 1..num_disciplinas where lugar[i] = l]) <= num_horas_lugar[l]
);

% Paso 9
var int: makespan = max([horario[i] + duraciones[i] | i in 1..num_disciplinas]);

solve minimize makespan;

% Paso 10
output [
    "Participantes asignados: ", show(participante), "\n",
    "Lugares asignados: ", show(lugar), "\n",
    "Horarios de inicio: ", show(horario), "\n",
    "Duraciones de las disciplinas: ", show(duraciones), "\n",
    "Tiempo total (makespan): ", show(makespan)
];
