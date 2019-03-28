param D>0 integer;
param E>0 integer;

set DEMAND	:=1..D;
set PATH {DEMAND};
set LINK	:=1..E;

param h {DEMAND};		#volume of d
param k {DEMAND};		#diversity of d
param l {DEMAND};		#length request of d
param q {LINK};			#probablity of attacked of link e
param cost {LINK};
param judge {d in DEMAND, e in LINK, PATH[d]};

var x {d in DEMAND, p in PATH[d]} >=0;	#flow on path p of demand d
var y {e in LINK} >=0;			#capacity of link e
var u {d in DEMAND, p in PATH[d]} binary;

minimize F: sum{e in LINK} cost[e]*y[e];


subj to flow_conservation {d in DEMAND}:
sum {p in PATH[d]} x[d,p]=h[d];

subj to link_capacity {e in LINK}:
sum {d in DEMAND}
	(sum {p in PATH[d]} x[d,p]*judge[d,e,p])<=y[e];

subj to demand_diversity {d in DEMAND, p in PATH[d]}:
x[d,p]<=u[d,p]*h[d]/k[d];

subj to demand_length {d in DEMAND, p in PATH[d]}:
sum {e in LINK} judge[d,e,p]>=l[d]*u[d,p];
