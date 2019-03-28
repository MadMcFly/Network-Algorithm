param V > 0 integer;
param E > 0 integer;
param D > 0 integer;

set Nodes   := 1..V;
set Links   := 1..E;
set Demands := 1..D;


## link generation
param link_src {Links} within Nodes;
param link_dst {Links} within Nodes;
param c {Links} > 0;

## demand generation
param demand_src {Demands} within Nodes;
param demand_dst {Demands} within Nodes;
param h {v1 in Nodes, v2 in Nodes} >= 0;
param H {v in Nodes} := sum {n in Nodes diff {v}} h[v,n];


## defining start and end nodes of the links
param a {e in Links, v in Nodes} 
	 := if link_src[e]=v then 1 else 0;
	 
param b {e in Links, v in Nodes} 
	 := if link_dst[e]=v then 1 else 0;	 
	 
# Variables
var x {Links,Nodes} >= 0; # flow variables
var y {Links} >= 0; # link load
var r {Links} >= 0; # link delay
	 
## objective function	 
minimize Cost: sum{e in Links} r[e];

## flow conservation1
subj to flow_conservation1 {v in Nodes}: 
sum{e in Links} a[e,v]*x[e,v] = H[v];

## flow conservation2
subj to flow_conservation2 {v1 in Nodes, v2 in Nodes diff {v1}}:  
(sum{e in Links} b[e,v2]*x[e,v1]) - (sum{e in Links} a[e,v2]*x[e,v1]) = h[v1,v2];

## link load constraint
subj to link_load {e in Links}:
sum{v in Nodes} x[e,v]=y[e];

## link capacity constraint2
subj to capacity2 {e in Links}:
y[e] <= c[e];

## Piece-wise linear model constraints
subj to pwc1 {e in Links}:
r[e] >= y[e];

subj to pwc2 {e in Links}:
r[e] >= 3*y[e]-2/3*c[e];

subj to pwc3 {e in Links}:
r[e] >= 10*y[e]-16/3*c[e];

subj to pwc4 {e in Links}:
r[e] >= 70*y[e]-178/3*c[e];

subj to pwc5 {e in Links}:
r[e] >= 500*y[e]-1468/3*c[e];

subj to pwc6 {e in Links}:
r[e] >= 5000*y[e]-16318/3*c[e];