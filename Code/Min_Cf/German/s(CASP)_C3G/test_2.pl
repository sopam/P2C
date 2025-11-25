%#include('Domain.pl').

#include('Domain_7.pl').
#include('C_pres_job_NeSY.pl').

%#include('Property.pl').
#include('Property_7.pl').

#include('Decision_rule.pl').
#include('Counterfactual_rule.pl').
#include('Realistic_instances.pl').
#include('ID.pl').
#include('Refined.pl').

#include('Original_sample.pl').
#include('Mutability.pl').
#include('Weight.pl').

%?-f_domain(marital_status,A),pre_marital_status(A),less_equal_50K(A,B,C).
%?-less_equal_50K(A,B,C).


%?- cf_less_equal_50K(A,B,C).

%?-pre_realistic(A,B,C,D,E).
%?-post_realistic(A,B,C,D,E,inp_cost(Inp_Ms, Inp_Reln), opt_cost(Opt_Ms, Opt_Reln)).



#show pre_property/5.
%?-refined(original('Married-civ-spouse',777,4,'Husband','Male'),id(Z1,Z2,Z3,Z4,Z5),counterfactual(Marital_Status,Capital_gain,Education_num,Relationship,Sex),weights(1,1,1,1,1),X,cost(O_Marital_Status,O_Capital_gain,O_Education_num,O_Relationship,O_Sex)).


?-original_sample(F_Checking_account_status, F_Credit_history, F_Property, F_Duration_months, F_Credit_amount, F_Present_employment_since, F_Job), 
    mutability(Z1,Z2,Z3,Z4,Z5,Z6,Z7), 
    weight(W1,W2,W3,W4,W5,W6,W7),
    refined(original(F_Checking_account_status, F_Credit_history, F_Property, F_Duration_months, F_Credit_amount, F_Present_employment_since, F_Job),
    id(Z1,Z2,Z3,Z4,Z5,Z6,Z7),
    counterfactual(Checking_account_status, Credit_history, Property, Duration_months, Credit_amount, Present_employment_since, Job),
    weights(W1,W2,W3,W4,W5,W6,W7),X,cost(O_Checking_account_status, O_Credit_history, O_Property, O_Duration_months, O_Credit_amount, O_Present_employment_since, O_Job)).

