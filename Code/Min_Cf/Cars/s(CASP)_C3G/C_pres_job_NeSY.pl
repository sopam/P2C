% Causal Rules: Causal rule showing the effect of Feature 'Job' on the Feature values of 'Present Employment Since'
constraint_pres_job(X,Y, cost(Inp,Inp)):- X = 'less_than1', Y \= 'unemployed/unskilled-non_resident'.
constraint_pres_job(X,Y, cost(Inp,Inp)):- X = '1=less_than_and_less_than4', Y \= 'unemployed/unskilled-non_resident'.
constraint_pres_job(X,Y, cost(Inp,Inp)):- X = '4=less_than_and_less_than7', Y \= 'unemployed/unskilled-non_resident'.
constraint_pres_job(X,Y, cost(Inp,Inp)):- X = 'greater_than7', Y \= 'unemployed/unskilled-non_resident'.

constraint_pres_job(X,Y, cost(Inp,Inp)):- X = 'unemployed', Y  = 'unemployed/unskilled-non_resident'.


