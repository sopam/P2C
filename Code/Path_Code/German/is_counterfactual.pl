#include('Draft_1_4.pl').
#include('Q.pl').


% Running the query returns all counterfactual instances.
is_counterfactual(A1,B1,C1,D1,E1,F1):-legal(2,A1,B1,C1,D1,E1,F1), constraint(A1,_,_,D1,E1,F1), not lite_le_50K(A1,B1,C1).
?-is_counterfactual(A1,B1,C1,D1,E1,F1).