# Indices

param N > 0 integer; # users to be connected
param M > 0 integer; # possible locations for nodes

set users   := 1..N;
set nodes   := 1..M;

# Parameters

param connection_cost {i in users, j in nodes} >= 0;

param K {i in users} >= 0;

# Variables

var u {i in users, j in nodes} binary;


# Objective

minimize F: sum{i in users} sum{j in nodes} (connection_cost[i,j]*u[i,j]);

# Constraints

subj to location_constraint {i in users}:
sum{j in nodes} u[i,j] = K[i];