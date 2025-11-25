#include('Draft_1_4.pl').



% Q: Decision Rules for negative/ undesired Outcome (’<=50K/yr’)
	#show lite_le_50K/3, not lite_le_50K/3.
    lite_le_50K(X,Y,Z) :- X = 'Married-civ-spouse', Y .=<. 5013.0, Z .=<. 12.0.
    lite_le_50K(X,Y,_) :- X \= 'Married-civ-spouse', Y .=<. 6849.0.


	
% Function to check/generate if an instance receives the negative outcome
    get_org(A,B,C,D,E):-legal(1,A,B,C,D,E), constraint(A,_,_,D,E, _), lite_le_50K(A,B,C).

% Function to check/generate if an instance receives the positive outcome/ counterfactual
    is_counterfactual(A1,B1,C1,D1,E1):-legal(1,A1,B1,C1,D1,E1), constraint(A1,_,_,D1,E1, _), not lite_le_50K(A1,B1,C1).



% Function to find the solution path to the counterfactual  

    get_path(_,_,_,_,_,T1,A,B,C,D,E,T1,A,B,C,D,E,No_Rep,Opt,Opt, O_Effort, O_Effort):-legal(T1,A,B,C,D,E), not lite_le_50K(A,B,C) , constraint(A,_,_,D,E, _).%constraint_reln_sex_age(D,E,F), constraint_ms_reln_age(A,D,F).
    
    get_path(Z1,Z2,Z3,Z4,Z5,T1,A,B,C,D,E,TN,A1,B1,C1,D1,E1,No_Rep,Acc,Opt, I_Effort, O_Effort):- T1 .=<. TN, 
        geq(C,C2)
        ,intervene(Z1,Z2,Z3,Z4,Z5,T1,A,B,C,D,E,T2,A2,B2,C2,D2,E2,Symbol,Cost)
        , anti_member_2(Symbol,No_Rep) 
        , anti_member([A2,B2,C2,D2,E2],Acc) 
        , legal(T1,A,B,C,D,E)
        , lite_le_50K(A,B,C)
        , Effort_1 .=. I_Effort + Cost
        , get_path(Z1,Z2,Z3,Z4,Z5,T2,A2,B2,C2,D2,E2,TN,A1,B1,C1,D1,E1,[Symbol|No_Rep],[state(time(T2),[A2,B2,C2,D2,E2]),Symbol|Acc], Opt, Effort_1, O_Effort).




% Added Constraints: Education num cannot decrease
geq(X,Y):- Y.>=.X. 



    % LPNMR, find path to CF % Works
    % Example: Set Path length to 3 to try and reach cf through 2 interventions
    % Make Sex, Marital_Status immutbale as a constraint. Done to utilize
    % The causal effect of `Relationship' on `Marital Status'
    %?- TN .=<. 5, Z1 = 0, Z2 = 0, Z3 = 0, Z4 = 1, Z5 = 0, Z6 = 0, T1 .=. 1, A = 'Never-married',B .=. 6000,
    %    C .=. 7, D = 'Unmarried', E = 'Male', F .=. 28, 
    %    get_path(Z1,Z2,Z3,Z4,Z5,Z6,T1,A,B,C,D,E,F,TN,A1,B1,C1,D1,E1,F1,[state(time(T1),[A,B,C,D,E,F])],Opt).



 % Testing 5 variables
     %?- TN .=<. 3, Z1 = 0, Z2 .=. 1, Z3 = 0, Z4 = 0, Z5 = 0, T1 .=. 1, A = 'Divorced',B .=. 6000,
     %   C .=. 7, D = 'Unmarried', E = 'Male', 
     %   get_path(Z1,Z2,Z3,Z4,Z5,T1,A,B,C,D,E,TN,A1,B1,C1,D1,E1,[],[state(time(T1),[A,B,C,D,E])],Opt).


 % Testing 5 variables
     ?- TN .=<. 4, Z1 = 0, Z2 .=. 1, Z3 = 0, Z4 = 0, Z5 = 0, T1 .=. 1, A = 'Divorced',B .=. 6000,
        C .=. 7, D = 'Unmarried', E = 'Male', 
        get_path(Z1,Z2,Z3,Z4,Z5,T1,A,B,C,D,E,TN,A1,B1,C1,D1,E1,[],[state(time(T1),[A,B,C,D,E])],Opt, 0, O_Effort).


 % Testing 5 variables
 %    ?- TN .=<. 7, Z1 = 1, Z2 .=. 1, Z3 = 0, Z4 = 0, Z5 = 0, T1 .=. 1, A = 'Divorced',B .=. 6000,
 %       C .=. 7, D = 'Unmarried', E = 'Male', 
 %       get_path(Z1,Z2,Z3,Z4,Z5,T1,A,B,C,D,E,TN,A1,B1,C1,D1,E1,[],[state(time(T1),[A,B,C,D,E])],Opt, 0, O_Effort).




 %% Testing with no limit on length
 %    ?- Z1 = 0, Z2 .=. 1, Z3 = 0, Z4 = 1, Z5 = 0, T1 .=. 1, A = 'Never-married',B .=. 6000,
 %       C .=. 7, D = 'Husband', E = 'Male', 
 %       get_path(Z1,Z2,Z3,Z4,Z5,T1,A,B,C,D,E,TN,A1,B1,C1,D1,E1,[],[state(time(T1),[A,B,C,D,E])],Opt).

%?-is_counterfactual(A1,B1,C1,D1,E1,F1).
%?-get_org(A,B,C,D,E,F).


%?- sex(1, 'Male'), sex(2, 'Female').
%?-legal(T1,A,B,C,D,E,F), not lite_le_50K(A,B,C) , constraint(A,_,_,D,E,F).


 % Testing 5 variables
     %?- Z1 = 0, Z2 .=. 1, Z3 = 1, Z4 = 0, Z5 = 1, T1 .=. 1, A = 'Divorced',B .=. 6000,
     %   C .=. 7, D = 'Unmarried', E = 'Male', 
     %   get_path(Z1,Z2,Z3,Z4,Z5,T1,A,B,C,D,E,TN,A1,B1,C1,D1,E1,[],[state(time(T1),[A,B,C,D,E])],Opt).