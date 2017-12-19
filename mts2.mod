#MULTICOMODITY

set K;  #Commoditys

set O; #Origins
set D; #Destinations
set T; #Transshipment

set N:= O union D  union T; #Nodes
set A, within N cross N; #Arcs of Network

###########################################

set Ak, within A cross K; #Arcs of Network per commodity

###########################################

param oik{i in O, k in K}; #Supply per commodity
param dik{i in D, k in K}; #Demand per commodity

param ug{(i,j) in A}; #capacity per arc
param uk{(i,j) in A, k in K}; #capacity per arc (per commodity)

param c{(i,j) in A, k in K}; #cost per commodity (per arc)

###########################################

var x{(i,j) in A, k in K} >= 0, integer;

###########################################
###########################################

minimize Z: sum{(i,j) in A, k in K} c[i,j,k]*x[i,j,k];

s.t. R1{k in K, i in O}: sum{j in N}x[i,j,k] - sum{j in N}x[j,i,k] = oik[i,k];

s.t. R2{k in K, i in D}: sum{j in N}x[i,j,k] - sum{j in N}x[j,i,k] = -1*dik[i,k];

s.t. R3{k in K, i in T}: sum{j in N}x[i,j,k] - sum{j in N}x[j,i,k] = 0;

s.t. R4{(i,j) in A, k in K}: x[i,j,k] <= uk[i,j,k];

s.t. R5{(i,j) in A}: sum{k in K}x[i,j,k] <= ug[i,j];

#s.t. R6{(i,j) in A, k in K}: x[i,j,k] >= 0;

###########################################
###########################################

data;

set K:= 'K_1', 'K_2';

set O:= 'O_1', 'O_2';
set D:= 'D_1', 'D_2', 'D_3';
set T:= 'T_1';

param oik:  'K_1' 'K_2' :=
      'O_1'   1000    0
      'O_2'   0     2000;

param dik:  'K_1' 'K_2' :=
      'D_1'   100    200
      'D_2'   0     1600
      'D_3'   1000    0;

param:  A:  ug:=
'O_1' 'O_1' 0
'O_2' 'O_1' 0
'T_1' 'O_1' 150
'D_1' 'O_1' 150
'D_2' 'O_1' 150
'D_3' 'O_1' 150
#
'O_1' 'O_2' 0
'O_2' 'O_2' 0
'T_1' 'O_2' 150
'D_1' 'O_2' 150
'D_2' 'O_2' 150
'D_3' 'O_2' 150
#
'O_1' 'T_1' 150
'O_2' 'T_1' 150
'T_1' 'T_1' 0
'D_1' 'T_1' 150
'D_2' 'T_1' 150
'D_3' 'T_1' 150
#
'O_1' 'D_1' 150
'O_2' 'D_1' 150
'T_1' 'D_1' 150
'D_1' 'D_1' 0
'D_2' 'D_1' 0
'D_3' 'D_1' 0
#
'O_1' 'D_2' 150
'O_2' 'D_2' 150
'T_1' 'D_2' 150
'D_1' 'D_2' 0
'D_2' 'D_2' 0
'D_3' 'D_2' 0
#
'O_1' 'D_3' 150
'O_2' 'D_3' 150
'T_1' 'D_3' 150
'D_1' 'D_3' 0
'D_2' 'D_3' 0
'D_3' 'D_3' 0;

param:   A:     K: uk :=
'O_1' 'O_1' 'K_1' 0
'O_2' 'O_1' 'K_1' 0
'T_1' 'O_1' 'K_1' 100
'D_1' 'O_1' 'K_1' 50
'D_2' 'O_1' 'K_1' 125
'D_3' 'O_1' 'K_1' 50
#
'O_1' 'O_2' 'K_1' 0
'O_2' 'O_2' 'K_1' 0
'T_1' 'O_2' 'K_1' 100
'D_1' 'O_2' 'K_1' 50
'D_2' 'O_2' 'K_1' 125
'D_3' 'O_2' 'K_1' 50
#
'O_1' 'T_1' 'K_1' 40
'O_2' 'T_1' 'K_1' 100
'T_1' 'T_1' 'K_1' 0
'D_1' 'T_1' 'K_1' 50
'D_2' 'T_1' 'K_1' 125
'D_3' 'T_1' 'K_1' 50
#
'O_1' 'D_1' 'K_1' 40
'O_2' 'D_1' 'K_1' 100
'T_1' 'D_1' 'K_1' 50
'D_1' 'D_1' 'K_1' 0
'D_2' 'D_1' 'K_1' 0
'D_3' 'D_1' 'K_1' 0
#
'O_1' 'D_2' 'K_1' 40
'O_2' 'D_2' 'K_1' 100
'T_1' 'D_2' 'K_1' 50
'D_1' 'D_2' 'K_1' 0
'D_2' 'D_2' 'K_1' 0
'D_3' 'D_2' 'K_1' 0
#
'O_1' 'D_3' 'K_1' 40
'O_2' 'D_3' 'K_1' 100
'T_1' 'D_3' 'K_1' 50
'D_1' 'D_3' 'K_1' 0
'D_2' 'D_3' 'K_1' 0
'D_3' 'D_3' 'K_1' 0
########^^^^^##########
'O_1' 'O_1' 'K_2' 0
'O_2' 'O_1' 'K_2' 0
'T_1' 'O_1' 'K_2' 25
'D_1' 'O_1' 'K_2' 25
'D_2' 'O_1' 'K_2' 10
'D_3' 'O_1' 'K_2' 50
#
'O_1' 'O_2' 'K_2' 0
'O_2' 'O_2' 'K_2' 0
'T_1' 'O_2' 'K_2' 25
'D_1' 'O_2' 'K_2' 25
'D_2' 'O_2' 'K_2' 10
'D_3' 'O_2' 'K_2' 50
#
'O_1' 'T_1' 'K_2' 90
'O_2' 'T_1' 'K_2' 25
'T_1' 'T_1' 'K_2' 0
'D_1' 'T_1' 'K_2' 25
'D_2' 'T_1' 'K_2' 10
'D_3' 'T_1' 'K_2' 50
#
'O_1' 'D_1' 'K_2' 90
'O_2' 'D_1' 'K_2' 25
'T_1' 'D_1' 'K_2' 25
'D_1' 'D_1' 'K_2' 0
'D_2' 'D_1' 'K_2' 0
'D_3' 'D_1' 'K_2' 0
#
'O_1' 'D_2' 'K_2' 90
'O_2' 'D_2' 'K_2' 25
'T_1' 'D_2' 'K_2' 25
'D_1' 'D_2' 'K_2' 0
'D_2' 'D_2' 'K_2' 0
'D_3' 'D_2' 'K_2' 0
#
'O_1' 'D_3' 'K_2' 90
'O_2' 'D_3' 'K_2' 25
'T_1' 'D_3' 'K_2' 25
'D_1' 'D_3' 'K_2' 0
'D_2' 'D_3' 'K_2' 0
'D_3' 'D_3' 'K_2' 0;

param c: A 'K_1' 'K_2' :=
'O_1' 'O_1' 9999     9999
'O_2' 'O_1' 9999     9999
'T_1' 'O_1' 10     20
'D_1' 'O_1' 15     15
'D_2' 'O_1' 12     24
'D_3' 'O_1' 16     12
#
'O_1' 'O_2' 9999     9999
'O_2' 'O_2' 9999     9999
'T_1' 'O_2' 10     20
'D_1' 'O_2' 15     15
'D_2' 'O_2' 12     24
'D_3' 'O_2' 16     12
#
'O_1' 'T_1' 18     18
'O_2' 'T_1' 12     14
'T_1' 'T_1' 9999     9999
'D_1' 'T_1' 15     15
'D_2' 'T_1' 12     24
'D_3' 'T_1' 16     12
#
'O_1' 'D_1' 15     15
'O_2' 'D_1' 12     24
'T_1' 'D_1' 16     12
'D_1' 'D_1' 9999     9999
'D_2' 'D_1' 9999     9999
'D_3' 'D_1' 9999     9999
#
'O_1' 'D_2' 15     15
'O_2' 'D_2' 12     24
'T_1' 'D_2' 16     12
'D_1' 'D_2' 9999     9999
'D_2' 'D_2' 9999     9999
'D_3' 'D_2' 9999     9999
#
'O_1' 'D_3' 15     15
'O_2' 'D_3' 12     24
'T_1' 'D_3' 16     12
'D_1' 'D_3' 9999     9999
'D_2' 'D_3' 9999     9999
'D_3' 'D_3' 9999     9999;

###########################################
###########################################

solve;

for {k in K}{
  printf "Transport cost: %s\n", sum{(i,j) in A} c[i,j,k]*x[i,j,k];
  printf "\n";
  printf "Origins     Destinies           Quantity \n";
  for {i in N} {
     for {j in N} {
        printf " %3s %15s %15s\n",i,j, x[i,j,k];
     }
  }
  
}

end;