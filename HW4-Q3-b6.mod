set A;			# Variable index SET
set B;      	# Constraint index SET
param p{A}; 	# Cost function coefficients
param o{B,A};   # right hand side coefficient of inequalities
param r{B};		# left hand side of inequalities

var x{A} ;
 
maximize Cost: 
sum {i in A} p[i]*x[i];

subj to limit {j in B}: 
sum {i in A} o[j,i]*x[i] <= r[j];

subj to limit2 {i in A}:
x[i] >= 0;

subj to limit3 {i in A}:
x[i] <= 1;

subj to limit4 :
x[3] = 1;

subj to limit5 :
x[1] = 0;

subj to limit6 :
x[4] = 0;

