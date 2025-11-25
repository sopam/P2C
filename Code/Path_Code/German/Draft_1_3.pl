
#include('Property_7.pl').






% As long as the feature values for marital_status, relationship and gender are in the domain, it is legal
% Verified- Works
%#show legal/7, not legal/7.
% CANNOT USE ANY STRUCTURE AS THEY DO NOT PRODUCE SAME NUIMBER OF NOT SOLUTIONS.





legal(X, Checking_account_status, Credit_history, Property, Duration_months, Credit_amount, Present_employment_since, Job) :-
   checking_account_status(X,Checking_account_status), 
   credit_history(X,Credit_history),
   property(X,Property),
   duration_months(X,Duration_months),
   credit_amount(X,Credit_amount),
   present_employment_since(X,Present_employment_since),
   job(X,Job).

   %?- legal(1,A,B,C,D,E,F,G).

