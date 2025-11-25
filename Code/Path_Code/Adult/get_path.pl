%#include('causal_constraints_extra.pl').
#include('causal_constraints_extra_2.pl').
%#include('Draft_1_4.pl').
#include('Original_Sample.pl').


% New
#include('Mutability.pl').
#include('Weight.pl').


% New
%#include('causal_constraints_extra.pl').
% Q: Decision Rules for negative/ undesired Outcome (’<=50K/yr’)
	#show lite_le_50K/3, not lite_le_50K/3.
    lite_le_50K(X,Y,Z) :- X = 'Married-civ-spouse', Y .=<. 5013.0, Z .=<. 12.0.
    lite_le_50K(X,Y,_) :- X \= 'Married-civ-spouse', Y .=<. 6849.0.


	
% Function to check/generate if an instance receives the negative outcome
    get_org(A,B,C,D,E):-legal(1,A,B,C,D,E), constraint(A,_,_,D,E, _), lite_le_50K(A,B,C).

% Function to check/generate if an instance receives the positive outcome/ counterfactual
    is_counterfactual(A1,B1,C1,D1,E1):-legal(1,A1,B1,C1,D1,E1), constraint(A1,_,_,D1,E1, _), not lite_le_50K(A1,B1,C1).



% Function to find the solution path to the counterfactual  

    get_path(act(_,_,_,_,_),wei(W1,W2,W3,W4,W5),time(T1),original(A,B,C,D,E),time(T1),counterfactual(A,B,C,D,E),No_Rep,Opt,Opt, O_Effort, O_Effort):-legal(T1,A,B,C,D,E), not lite_le_50K(A,B,C) , constraint(wei(W1,W2,W3,W4,W5),A,_,_,D,E, _).%constraint_reln_sex_age(D,E,F), constraint_ms_reln_age(A,D,F).
    
    get_path(act(Z1,Z2,Z3,Z4,Z5),wei(W1,W2,W3,W4,W5),time(T1),original(A,B,C,D,E),time(TN),counterfactual(A1,B1,C1,D1,E1),No_Rep,Acc,Opt, I_Effort, O_Effort):- T1 .=<. TN, I_Effort .=<. O_Effort,
        geq(C,C2)
        ,intervene(act(Z1,Z2,Z3,Z4,Z5),wei(W1,W2,W3,W4,W5),time(T1),original(A,B,C,D,E),time(T2),counterfactual(A2,B2,C2,D2,E2),Symbol,Cost)

        , check_if_not_married(A2,Acc)

        ,check_if_separated(A2,Acc)
        ,check_if_divorced(A2,Acc)
 
        , anti_member([A2,B2,C2,D2,E2],Acc) 
        , legal(T1,A,B,C,D,E)
        , lite_le_50K(A,B,C)
        , Effort_1 .=. I_Effort + Cost
        , get_path(act(Z1,Z2,Z3,Z4,Z5),wei(W1,W2,W3,W4,W5),time(T2),original(A2,B2,C2,D2,E2),time(TN),counterfactual(A1,B1,C1,D1,E1),[Symbol|No_Rep],[state(time(T2),[A2,B2,C2,D2,E2]),Symbol|Acc], Opt, Effort_1, O_Effort).




% Added Constraints: Education num cannot decrease
geq(X,Y):- Y.>=.X. 

