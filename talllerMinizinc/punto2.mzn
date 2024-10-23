% Paso 1
int: num_productos = 5;
int: num_estanterias = 3;

% Paso 2
array[1..num_estanterias] of int: capacidad_estanterias = [8, 6, 5];

% Paso 3
array[1..num_productos] of int: volumenes = [4, 3, 5, 2, 1];

% Paso 4
array[1..num_productos] of int: prioridades = [1, 3, 2, 1, 2];

constraint forall(i in 1..num_productos, j in i+1..num_productos)(
    prioridades[i] < prioridades[j] -> estanteria_asignada[i] <= estanteria_asignada[j]
);

% Paso 5
constraint forall(e in 1..num_estanterias)(
    sum([volumenes[i] | i in 1..num_productos where estanteria_asignada[i] = e]) <= capacidad_estanterias[e]
);

% Paso 6
constraint estanteria_asignada[1] != estanteria_asignada[3];

%paso 7
array[1..num_productos] of int: tiempos_entrega = [2, 5, 3, 1, 4];

%paso 8
array[1..num_productos] of var 1..num_estanterias: estanteria_asignada;

% Paso 9
var int: espacio_usado = sum([volumenes[i] | i in 1..num_productos]);

solve minimize espacio_usado;

% Paso 10
output [
    "Asignación de productos a estanterías: ", show(estanteria_asignada), "\n",
    "Espacio total utilizado: ", show(espacio_usado), " m³\n"
];
