set A;			# Variable index SET
set B;      	# Constraint index SET
param p{A}; 	# Cost function coefficients
param o{B,A};   # left hand side coefficient of inequalities
param r{B};		# right hand side of inequalities
Cost;

var x{A} binary;
 
maximize Cost: 
sum {i in A} p[i]*x[i];

subj to limit {j in B}: 
sum {i in A} o[j,i]*x[i] <= r[j];

#subject to limit {t in 1..T}: sum {j in prd} Make[j,t] <= max_prd;

