% Causal Rules

%constraint_PES_job(X,Y,Z, cost(_,0)):- Z = 'unemployed',X = 'unemployed', Y = 'unemployed/unskilled-non-resident'.
constraint_PES_job(X,Y,Z, cost(_,1)):- Z = 'unemployed',X = '<1_year', Y \= 'unemployed/unskilled-non-resident'. % Cost 0
constraint_PES_job(X,Y,Z, cost(W,W)):- Z = 'unemployed',X = '1=<_and_<4_years', Y \= 'unemployed/unskilled-non-resident'. % Cost 1
constraint_PES_job(X,Y,Z, cost(W,Total_Cost)):- Z = 'unemployed',X = '4=<_and_<7_years', Y \= 'unemployed/unskilled-non-resident', Total_Cost .=. W*1. % Cost 4
constraint_PES_job(X,Y,Z, cost(W,Total_Cost)):- Z = 'unemployed',X = '>=7_years', Y \= 'unemployed/unskilled-non-resident', Total_Cost .=. W*1. % Cost 7


%constraint_PES_job(X,Y,Z, cost(_,0)):- Z = '<1_year',X = '<1_year', Y \= 'unemployed/unskilled-non-resident'.
constraint_PES_job(X,Y,Z, cost(W,W)):- Z = '<1_year',X = '1=<_and_<4_years', Y \= 'unemployed/unskilled-non-resident'. % Cost 1
constraint_PES_job(X,Y,Z, cost(W,Total_Cost)):- Z = '<1_year',X = '4=<_and_<7_years', Y \= 'unemployed/unskilled-non-resident', Total_Cost .=. W*1. % Cost 4
constraint_PES_job(X,Y,Z, cost(W,Total_Cost)):- Z = '<1_year',X = '>=7_years', Y \= 'unemployed/unskilled-non-resident', Total_Cost .=. W*1. % Cost 7

%constraint_PES_job(X,Y,Z, cost(_,0)):- Z = '1=<_and_<4_years',X = '1=<_and_<4_years', Y \= 'unemployed/unskilled-non-resident'.
constraint_PES_job(X,Y,Z, cost(W,W)):- Z = '1=<_and_<4_years',X = '4=<_and_<7_years', Y \= 'unemployed/unskilled-non-resident'. % Cost 1
constraint_PES_job(X,Y,Z, cost(W,Total_Cost)):- Z = '1=<_and_<4_years',X = '>=7_years', Y \= 'unemployed/unskilled-non-resident', Total_Cost .=. W*1. % Cost 4

%constraint_PES_job(X,Y,Z, cost(_,0)):- Z = '4=<_and_<7_years',X = '4=<_and_<7_years', Y \= 'unemployed/unskilled-non-resident'.
constraint_PES_job(X,Y,Z, cost(W,W)):- Z = '4=<_and_<7_years',X = '>=7_years', Y \= 'unemployed/unskilled-non-resident'. % Cost 1


%constraint_PES_job(X,Y,Z, cost(_,0)):- Z = '>=7_years',X = '>=7_years', Y \= 'unemployed/unskilled-non-resident'.


constraint_PES_job(X,Y,Z, cost(_,1)):- Z  \= 'unemployed', X = 'unemployed', Y  = 'unemployed/unskilled-non-resident'. % Cost 0


