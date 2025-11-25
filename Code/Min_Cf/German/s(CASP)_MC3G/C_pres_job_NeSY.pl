% Causal Rules: Causal rule showing the effect of Feature 'Job' on the Feature values of 'Present Employment Since'
constraint_pres_job(X,Y, cost(_,0)):- X = 'less_than1', Y \= 'unemployed/unskilled-non_resident'.
constraint_pres_job(X,Y, cost(_,0)):- X = '1equalsless_than_and_less_than4', Y \= 'unemployed/unskilled-non_resident'.
constraint_pres_job(X,Y, cost(_,0)):- X = '4equalsless_than_and_less_than7', Y \= 'unemployed/unskilled-non_resident'.
constraint_pres_job(X,Y, cost(_,0)):- X = 'greater_than7', Y \= 'unemployed/unskilled-non_resident'.

constraint_pres_job(X,Y, cost(_,0)):- X = 'unemployed', Y  = 'unemployed/unskilled-non_resident'.



% Causal Rules: Causal rule showing the effect of Feature 'Job' on the Feature values of 'Present Employment Since'
%constraint_pres_job(X,Y, cost(Inp,Inp)):- X = 'less_than1', Y \= 'unemployed/unskilled-non_resident'.
%constraint_pres_job(X,Y,cost(Inp,Inp)):- X = '1equalsless_than_and_less_than4', Y \= 'unemployed/unskilled-non_resident'.
%constraint_pres_job(X,Y, cost(Inp,Inp)):- X = '4equalsless_than_and_less_than7', Y \= 'unemployed/unskilled-non_resident'.
%constraint_pres_job(X,Y, cost(Inp,Inp)):- X = 'greater_than7', Y \= 'unemployed/unskilled-non_resident'.

%constraint_pres_job(X,Y, cost(Inp,Inp)):- X = 'unemployed', Y  = 'unemployed/unskilled-non_resident'.



