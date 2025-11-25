#include('Draft_1_4.pl').
#include('Original_Sample.pl').


% New
#include('Actionability.pl').
#include('Weight.pl').



% Q: Decision Rules for negative/ undesired Outcome (’<=50K/yr’)
    lite_good_credit(A,_,_,_,_):- A = 'no_checking_account'.
    lite_good_credit(A,B,C,D,E):- A \= 'no_checking_account', B \= 'all credits at this bank paid back duly', 
                                    D .=<. 21,E .>. 428,not ab1(C,E).
    ab1(C,E):- C = 'car or other', E .=<. 1345. 



% Function to find the solution path to the counterfactual  
    
#show intervention/3.
    get_path(act(_,_,_,_,_,_,_),wei(_,_,_,_,_,_,_),time(T1),original(A,B,C,D,E,F,G),time(T1),counterfactual(A,B,C,D,E,F,G),No_Rep,Opt,Opt, O_Effort, O_Effort):-legal(T1,A,B,C,D,E,F,G), constraint_PES_job(F,G,_, cost(_,_)), not lite_good_credit(A,B,C,D,E).
    
    get_path(act(Z1,Z2,Z3,Z4,Z5,Z6,Z7),wei(W1,W2,W3,W4,W5,W6,W7),time(T1),original(A,B,C,D,E,F,G),time(TN),counterfactual(A1,B1,C1,D1,E1,F1,G1),No_Rep,Acc,Opt, I_Effort, O_Effort):- T1 .=<. TN, I_Effort .=<. O_Effort
        ,intervene(act(Z1,Z2,Z3,Z4,Z5,Z6,Z7),wei(W1,W2,W3,W4,W5,W6,W7),time(T1),original(A,B,C,D,E,F,G),time(T2),counterfactual(A2,B2,C2,D2,E2,F2,G2),Symbol,Cost)
        , anti_member_2(Symbol,No_Rep) 
        , anti_member([A2,B2,C2,D2,E2,F2,G2],Acc) 
        , legal(T1,A,B,C,D,E,F,G)
        , lite_good_credit(A,B,C,D,E)
        , Effort_1 .=. I_Effort + Cost
        , get_path(act(Z1,Z2,Z3,Z4,Z5,Z6,Z7),wei(W1,W2,W3,W4,W5,W6,W7),time(T2),original(A2,B2,C2,D2,E2,F2,G2),time(TN),counterfactual(A1,B1,C1,D1,E1,F1,G1),[Symbol|No_Rep],[state(time(T2),[A2,B2,C2,D2,E2,F2,G2]),Symbol|Acc], Opt, Effort_1, O_Effort).




%?-  %O_Effort .=<. 2 , 
    %TN .=<. 3, 
?-O_Effort .=. 1, T1 .=. 1, A ='no_checking_account', B = 'no credits taken/ all credits paid back duly',
        C = 'real estate', D .=. 7, E .=. 500, F =  'unemployed', G = 'unemployed/unskilled-non-resident',
         get_path(act(1,0,0,0,0,0,0),wei(1,1,1,1,1,1,1),time(T1),original(A,B,C,D,E,F,G),time(TN),counterfactual(A1,B1,C1,D1,E1,F1,G1),[],[state(time(T1),[A,B,C,D,E,F,G])],Opt, 0, O_Effort).



?-O_Effort .=. 2, T1 .=. 1, A ='no_checking_account', B = 'no credits taken/ all credits paid back duly',
        C = 'real estate', D .=. 7, E .=. 500, F =  '<1_year', G = 'official/skilled-employee',
         get_path(act(1,0,0,0,0,0,0),wei(1,1,1,1,1,1,1),time(T1),original(A,B,C,D,E,F,G),time(TN),counterfactual(A1,B1,C1,D1,E1,F1,G1),[],[state(time(T1),[A,B,C,D,E,F,G])],Opt, 0, O_Effort).


?-O_Effort .=. 2, T1 .=. 0, A ='no_checking_account', B = 'no credits taken/ all credits paid back duly',
        C = 'real estate', D .=. 7, E .=. 500, F =  '1=<_and_<4_years', G = 'official/skilled-employee',
         get_path(act(1,0,0,0,0,0,1),wei(1,1,1,1,1,1,1),time(T1),original(A,B,C,D,E,F,G),time(TN),counterfactual(A1,B1,C1,D1,E1,F1,G1),[],[state(time(T1),[A,B,C,D,E,F,G])],Opt, 0, O_Effort).

% Full D
?-O_Effort .=. 2, T1 .=. 0, A ='no_checking_account', B = 'no credits taken/ all credits paid back duly',
        C = 'real estate', D .=. 7, E .=. 500, F =  '1=<_and_<4_years', G = 'official/skilled-employee',
         get_path(act(1,1,1,1,1,1,1),wei(1,1,1,1,1,1,1),time(T1),original(A,B,C,D,E,F,G),time(TN),counterfactual(A1,B1,C1,D1,E1,F1,G1),[],[state(time(T1),[A,B,C,D,E,F,G])],Opt, 0, O_Effort).



