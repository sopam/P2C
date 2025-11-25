%#include('Domain.pl').

#include('Domain_7.pl').
#include('C_ms_reln_NeSY.pl').
#include('C_reln_sex_NeSY.pl').
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



#show pre_sex/5.
?-refined(original('Married-civ-spouse',777,4,'Husband','Male'),id(Z1,Z2,Z3,Z4,Z5),counterfactual(Marital_Status,Capital_gain,Education_num,Relationship,Sex),weights(1,1,1,1,1),X,cost(O_Marital_Status,O_Capital_gain,O_Education_num,O_Relationship,O_Sex)).



?-original_sample(F_Marital_Status, F_Relationship, F_Sex, F_Capital_gain, F_Education_num) , 
    mutability(Z1,Z2,Z3,Z4,Z5), 
    weight(W1,W2,W3,W4,W5),
    refined(original(F_Marital_Status, F_Relationship, F_Sex, F_Capital_gain, F_Education_num),id(Z1,Z2,Z3,Z4,Z5),counterfactual(Marital_Status,Capital_gain,Education_num,Relationship,Sex),weights(W1,W2,W3,W4,W5),X,cost(O_Marital_Status,O_Capital_gain,O_Education_num,O_Relationship,O_Sex)).

