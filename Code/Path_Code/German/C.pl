% Causal Rules
constraint_PES_job(X,Y, cost(_,0)):- X = '<1_year', Y \= 'unemployed/unskilled-non-resident'.
constraint_PES_job(X,Y, cost(_,0)):- X = '1=<_and_<4_years', Y \= 'unemployed/unskilled-non-resident'.
constraint_PES_job(X,Y, cost(_,0)):- X = '4=<_and_<7_years', Y \= 'unemployed/unskilled-non-resident'.
constraint_PES_job(X,Y, cost(_,0)):- X = '>=7_years', Y \= 'unemployed/unskilled-non-resident'.

constraint_PES_job(X,Y, cost(_,0)):- X = 'unemployed', Y  = 'unemployed/unskilled-non-resident'.


