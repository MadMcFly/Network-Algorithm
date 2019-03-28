# Indices

param N > 0 integer; # areas to be connected
param M > 0 integer; # possible locations for nodes

set areas   := 1..N;
set nodes   := 1..M;

# Parameters

param connection_cost {i in areas, j in nodes} >= 0;
param open_cost {j in nodes} >= 0;
param K {j in nodes} >= 0;

# Variables

var u {i in areas, j in nodes} binary;
var r {j in nodes} binary;

# Objective

minimize F: sum{i in areas} sum{j in nodes} (connection_cost[i,j]*u[i,j]) + sum{j in nodes} open_cost[j]*r[j];

# Constraints

subj to location_constraint {i in areas}:
sum{j in nodes} u[i,j] = 1;

subj to area_constraint {j in nodes}:
sum{i in nodes} u[i,j] <= K[j]*r[j];