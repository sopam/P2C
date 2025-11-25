
#include('Draft_1_3.pl').

%#include('C.pl').


#include('C_ms_reln_NeSY.pl').
#include('C_reln_sex_NeSY.pl').



%#show lite_direct/2, not lite_direct/2.
alter(0,X,X).
alter(1,X,Y).






% Combining Causal Order:
    constraint(wei(W1,W2,W3,W4,W5),A,B,C,D,E, Total_Cost):- constraint_reln_sex(D,E, cost(W4,Opt_Cost_1)), constraint_ms_reln(A,D, cost(W1,Opt_Cost_2)), Total_Cost .=. Opt_Cost_1+Opt_Cost_2.
    
    %constraint(_,_,_,D,E):- constraint_reln_sex(D,E).
    %constraint(A,_,_,D,_):- constraint_ms_reln(A,D).

% Here 0 is the cost

lite_intervene(act(Z1,Z2,Z3,Z4,Z5),wei(W1,W2,W3,W4,W5),time(P),original(A,B,C,D,E), time(Q),counterfactual(A1,B1,C1,D1,E1),Symbol, Total_cost):- 
    lite_causal(act(Z1,Z2,Z3,Z4,Z5),wei(W1,W2,W3,W4,W5),time(P),original(A,B,C,D,E), time(Q),counterfactual(A1,B1,C1,D1,E1),Symbol,Total_cost).
lite_intervene(act(Z1,Z2,Z3,Z4,Z5),wei(W1,W2,W3,W4,W5),time(P),original(A,B,C,D,E), time(Q),counterfactual(A1,B1,C1,D1,E1),Symbol, Total_cost):- 
    lite_direct(act(Z1,Z2,Z3,Z4,Z5),wei(W1,W2,W3,W4,W5),time(P),original(A,B,C,D,E), time(Q),counterfactual(A1,B1,C1,D1,E1),Symbol, Total_cost).



%#show lite_causal/10.
% Com,bines the changes over the marital status and relationship Status'):- 
lite_causal(act(Z1,Z2,Z3,Z4,Z5),wei(W1,W2,W3,W4,W5),time(P),original(A,B,C,D,E), time(Q),counterfactual(A1,B,C,D1,E),'<-C',Total_Cost):- D1 = D, constraint(wei(W1,W2,W3,0,W5),A1,_,_,D1,E, Total_Cost).
lite_causal(act(Z1,Z2,Z3,Z4,Z5),wei(W1,W2,W3,W4,W5),time(P),original(A,B,C,D,E), time(Q),counterfactual(A1,B,C,D1,E),'<-C',Total_Cost):- D1 \= D, constraint(wei(W1,W2,W3,W4,W5),A1,_,_,D1,E, Total_Cost).

%lite_causal(act(Z1,Z2,Z3,Z4,Z5,Z6),P,A,B,C,D,E,F, Q,A,B,C,D1,E,F,'<-C:'):- constraint_reln_sex_age(D1,E,F).
%lite_causal(act(Z1,Z2,Z3,Z4,Z5,Z6),P,A,B,C,D,E,F, Q,A1,B,C,D,E,F,'<-C:'):- constraint_ms_reln_age(A1,E,F).


%#show lite_direct/10.



lite_direct(act(Z1,Z2,Z3,Z4,Z5),wei(W1,W2,W3,W4,W5),time(P),original(A,B,C,D,E), time(Q),counterfactual(A1,B1,C1,D1,E1),'<-D5',W5):- 
    alter(Z1,A,A1), 
    alter(Z2,B,B1), 
    alter(Z3,C,C1), 
    alter(Z4,D,D1), 
    alter(Z5,E,E1), 
    A = A1, 
    B = B1, 
    C = C1,
    D = D1,
    E \= E1.

lite_direct(act(Z1,Z2,Z3,Z4,Z5),wei(W1,W2,W3,W4,W5),time(P),original(A,B,C,D,E), time(Q),counterfactual(A1,B1,C1,D1,E1),'<-D4',W4):- 
    alter(Z1,A,A1), 
    alter(Z2,B,B1), 
    alter(Z3,C,C1), 
    alter(Z4,D,D1), 
    alter(Z5,E,E1), 
    A = A1, 
    B = B1, 
    C = C1,
    D \= D1,
    E = E1.


lite_direct(act(Z1,Z2,Z3,Z4,Z5),wei(W1,W2,W3,W4,W5),time(P),original(A,B,C,D,E), time(Q),counterfactual(A1,B1,C1,D1,E1),'<-D3',W3):- 
    alter(Z1,A,A1), 
    alter(Z2,B,B1), 
    alter(Z3,C,C1), 
    alter(Z4,D,D1), 
    alter(Z5,E,E1), 
    A = A1, 
    B = B1, 
    C \= C1,
    D = D1,
    E = E1.

lite_direct(act(Z1,Z2,Z3,Z4,Z5),wei(W1,W2,W3,W4,W5),time(P),original(A,B,C,D,E), time(Q),counterfactual(A1,B1,C1,D1,E1),'<-D2',W2):- 
    alter(Z1,A,A1), 
    alter(Z2,B,B1), 
    alter(Z3,C,C1), 
    alter(Z4,D,D1), 
    alter(Z5,E,E1), 
    A = A1, 
    B \= B1, 
    C = C1,
    D = D1,
    E = E1.

lite_direct(act(Z1,Z2,Z3,Z4,Z5),wei(W1,W2,W3,W4,W5),time(P),original(A,B,C,D,E), time(Q),counterfactual(A1,B1,C1,D1,E1),'<-D1',W1):- 
    alter(Z1,A,A1), 
    alter(Z2,B,B1), 
    alter(Z3,C,C1), 
    alter(Z4,D,D1), 
    alter(Z5,E,E1), 
    A \= A1, 
    B = B1, 
    C = C1,
    D = D1,
    E = E1.

% Show intervene
intervene(act(Z1,Z2,Z3,Z4,Z5),wei(W1,W2,W3,W4,W5),time(P),original(A,B,C,D,E), time(Q),counterfactual(A1,B1,C1,D1,E1),Symbol,Cost):- Q.=. P+1,
                                capital_gain(Q,B1), 
                                capital_gain(P,B), 

                                education_num(Q,C1), 
                                education_num(P,C), 
                                
                                marital_status(Q,A1),                            
                                marital_status(P,A),


                                
                                sex(Q,E1),
                                sex(P,E),

                                relationship(Q,D1),
                                relationship(P,D),
                                lite_intervene(act(Z1,Z2,Z3,Z4,Z5),wei(W1,W2,W3,W4,W5),time(P),original(A,B,C,D,E), time(Q),counterfactual(A1,B1,C1,D1,E1),Symbol,Cost).

                                
%?-intervene(1,1,1,1,1,1,1,married_civ_spouse,5013,7,wife,female,23, 2,A1,B1,C1,D1,E1,F1,Symbol).

%?-intervene(1,1,1,1,1,1,1,married_civ_spouse,5013,7,husband,male,28, 2,A1,B1,C1,D1,E1,F1,Symbol).

%?-intervene(1,1,1,1,1,1,1,married_civ_spouse,5013,7,wife,female,23, 2,married_civ_spouse,5013,C1,wife,female,23,Symbol).

%?-intervene(1,1,1,1,1,1,'Divorced',5013,7,'Unmarried','Female', 2,A1,B1,C1,D1,E1,Symbol).
