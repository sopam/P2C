#include('Domain_7.pl').
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


?-original_sample(F_Persons, F_Safety, F_Buying, F_Maint), 
    mutability(Z1,Z2,Z3,Z4), 
    weight(W1,W2,W3,W4),
    refined(original(F_Persons, F_Safety, F_Buying, F_Maint),
    id(Z1,Z2,Z3,Z4),
    counterfactual(Persons, Safety, Buying, Maint),
    weights(W1,W2,W3,W4),X,cost(O_Persons, O_Safety, O_Buying, O_Maint)).

%?-pre_realistic(A,B,C,D).
%?- reject('more','high','vhigh','vhigh').