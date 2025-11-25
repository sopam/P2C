
#include('Draft_1_3.pl').

%#include('C.pl').
#include('C_updated.pl').




%#show lite_direct/2, not lite_direct/2.
alter(0,X,X).
alter(1,X,Y).






% Combining Causal Order:
    % For C.pl
    %constraint(wei(W1,W2,W3,W4,W5,W6,W7),A,B,C,D,E,F,G, Total_Cost):- constraint_PES_job(F,G, cost(W6,Total_Cost)).

    % For C_updated.pl
    constraint(wei(W1,W2,W3,W4,W5,W6,W7),F1,G,F, Total_Cost):- constraint_PES_job(F1,G, F, cost(W6,Total_Cost)).
    


% Here 0 is the cost

lite_intervene(act(Z1,Z2,Z3,Z4,Z5,Z6,Z7),wei(W1,W2,W3,W4,W5,W6,W7),time(P),original(A,B,C,D,E,F,G), time(Q),counterfactual(A1,B1,C1,D1,E1,F1,G1),Symbol, Total_cost):- 
   lite_causal(act(Z1,Z2,Z3,Z4,Z5,Z6,Z7),wei(W1,W2,W3,W4,W5,W6,W7),time(P),original(A,B,C,D,E,F,G), time(Q),counterfactual(A1,B1,C1,D1,E1,F1,G1),Symbol, Total_cost).
lite_intervene(act(Z1,Z2,Z3,Z4,Z5,Z6,Z7),wei(W1,W2,W3,W4,W5,W6,W7),time(P),original(A,B,C,D,E,F,G), time(Q),counterfactual(A1,B1,C1,D1,E1,F1,G1),Symbol, Total_cost):- 
    lite_direct(act(Z1,Z2,Z3,Z4,Z5,Z6,Z7),wei(W1,W2,W3,W4,W5,W6,W7),time(P),original(A,B,C,D,E,F,G), time(Q),counterfactual(A1,B1,C1,D1,E1,F1,G1),Symbol, Total_cost).



%#show lite_causal/10.
% For C.pl
%lite_causal(act(Z1,Z2,Z3,Z4,Z5,Z6,Z7),wei(W1,W2,W3,W4,W5,W6,W7),time(P),original(A,B,C,D,E,F,G), time(Q),counterfactual(A,B,C,D,E,F1,G),'<-C',Total_Cost):- F1 = F, constraint(wei(W1,W2,W3,W4,W5,0,W7),A,B,C,D,E,F1,G, Total_Cost).
%lite_causal(act(Z1,Z2,Z3,Z4,Z5,Z6,Z7),wei(W1,W2,W3,W4,W5,W6,W7),time(P),original(A,B,C,D,E,F,G), time(Q),counterfactual(A,B,C,D,E,F1,G),'<-C',Total_Cost):- F1 \= F, constraint(wei(W1,W2,W3,W4,W5,W6,W7),A,B,C,D,E,F1,G, Total_Cost).

% For C_updated.pl
%%lite_causal(act(Z1,Z2,Z3,Z4,Z5,Z6,Z7),wei(W1,W2,W3,W4,W5,W6,W7),time(P),original(A,B,C,D,E,F,G), time(Q),counterfactual(A,B,C,D,E,F1,G),'<-D6',Total_Cost):- F1 = F, constraint(wei(W1,W2,W3,W4,W5,0,W7),F1,G,F, Total_Cost).
%lite_causal(act(Z1,Z2,Z3,Z4,Z5,Z6,Z7),wei(W1,W2,W3,W4,W5,W6,W7),time(P),original(A,B,C,D,E,F,G), time(Q),counterfactual(A,B,C,D,E,F1,G),'<-D6',Total_Cost):- F1 \= F, constraint(wei(W1,W2,W3,W4,W5,W6,W7),F1,G,F, Total_Cost).

% For C_2_updated.pl
% Since when Job changes, Time resets
%lite_causal(act(Z1,Z2,Z3,Z4,Z5,Z6,Z7),wei(W1,W2,W3,W4,W5,W6,W7),time(P),original(A,B,C,D,E,F,G), time(Q),counterfactual(A,B,C,D,E,'<1_year',G1),'<-DC7',W7):- alter(Z7,G,G1), G1 \= G
%    , G1 \= 'unemployed/unskilled-non-resident'.

%lite_causal(act(Z1,Z2,Z3,Z4,Z5,Z6,Z7),wei(W1,W2,W3,W4,W5,W6,W7),time(P),original(A,B,C,D,E,F,G), time(Q),counterfactual(A,B,C,D,E,'unemployed',G1),'<-DC7',W7):- alter(Z7,G,G1), G1 \= G
%    , G1 = 'unemployed/unskilled-non-resident'.



%#show lite_direct/10.

lite_direct(act(Z1,Z2,Z3,Z4,Z5,Z6,Z7),wei(W1,W2,W3,W4,W5,W6,W7),time(P),original(A,B,C,D,E,F,G), time(Q),counterfactual(A1,B1,C1,D1,E1,F1,G1),'<-D1',W1):- 
    alter(Z1,A,A1), 
    alter(Z2,B,B1), 
    alter(Z3,C,C1), 
    alter(Z4,D,D1), 
    alter(Z5,E,E1), 
    alter(Z6,F,F1), 
    alter(Z7,G,G1), 
    A \= A1, 
    B = B1, 
    C = C1,
    D = D1,
    E = E1,
    F = F1,
    G = G1.

lite_direct(act(Z1,Z2,Z3,Z4,Z5,Z6,Z7),wei(W1,W2,W3,W4,W5,W6,W7),time(P),original(A,B,C,D,E,F,G), time(Q),counterfactual(A1,B1,C1,D1,E1,F1,G1),'<-D2',W2):- 
    alter(Z1,A,A1), 
    alter(Z2,B,B1), 
    alter(Z3,C,C1), 
    alter(Z4,D,D1), 
    alter(Z5,E,E1), 
    alter(Z6,F,F1), 
    alter(Z7,G,G1), 
    A = A1, 
    B \= B1, 
    C = C1,
    D = D1,
    E = E1,
    F = F1,
    G = G1.

lite_direct(act(Z1,Z2,Z3,Z4,Z5,Z6,Z7),wei(W1,W2,W3,W4,W5,W6,W7),time(P),original(A,B,C,D,E,F,G), time(Q),counterfactual(A1,B1,C1,D1,E1,F1,G1),'<-D3',W3):- 
    alter(Z1,A,A1), 
    alter(Z2,B,B1), 
    alter(Z3,C,C1), 
    alter(Z4,D,D1), 
    alter(Z5,E,E1), 
    alter(Z6,F,F1), 
    alter(Z7,G,G1), 
    A = A1, 
    B = B1, 
    C \= C1,
    D = D1,
    E = E1,
    F = F1,
    G = G1.

lite_direct(act(Z1,Z2,Z3,Z4,Z5,Z6,Z7),wei(W1,W2,W3,W4,W5,W6,W7),time(P),original(A,B,C,D,E,F,G), time(Q),counterfactual(A1,B1,C1,D1,E1,F1,G1),'<-D4',W4):- 
    alter(Z1,A,A1), 
    alter(Z2,B,B1), 
    alter(Z3,C,C1), 
    alter(Z4,D,D1), 
    alter(Z5,E,E1), 
    alter(Z6,F,F1), 
    alter(Z7,G,G1), 
    A = A1, 
    B = B1, 
    C = C1,
    D \= D1,
    E = E1,
    F = F1,
    G = G1.

lite_direct(act(Z1,Z2,Z3,Z4,Z5,Z6,Z7),wei(W1,W2,W3,W4,W5,W6,W7),time(P),original(A,B,C,D,E,F,G), time(Q),counterfactual(A1,B1,C1,D1,E1,F1,G1),'<-D5',W5):- 
    alter(Z1,A,A1), 
    alter(Z2,B,B1), 
    alter(Z3,C,C1), 
    alter(Z4,D,D1), 
    alter(Z5,E,E1), 
    alter(Z6,F,F1), 
    alter(Z7,G,G1), 
    A = A1, 
    B = B1, 
    C = C1,
    D = D1,
    E \= E1,
    F = F1,
    G = G1.



% Show intervene
intervene(act(Z1,Z2,Z3,Z4,Z5,Z6,Z7),wei(W1,W2,W3,W4,W5,W6,W7),time(P),original(A,B,C,D,E,F,G), time(Q),counterfactual(A1,B1,C1,D1,E1,F1,G1),Symbol,Cost):- Q.=. P+1,
                                legal(P,A,B,C,D,E,F,G),
                                legal(Q,A1,B1,C1,D1,E1,F1,G1),
                                lite_intervene(act(Z1,Z2,Z3,Z4,Z5,Z6,Z7),wei(W1,W2,W3,W4,W5,W6,W7),time(P),original(A,B,C,D,E,F,G), time(Q),counterfactual(A1,B1,C1,D1,E1,F1,G1),Symbol,Cost).

                                
%?-intervene(1,1,1,1,1,1,1,married_civ_spouse,5013,7,wife,female,23, 2,A1,B1,C1,D1,E1,F1,Symbol).

%?-intervene(1,1,1,1,1,1,1,married_civ_spouse,5013,7,husband,male,28, 2,A1,B1,C1,D1,E1,F1,Symbol).

%?-intervene(1,1,1,1,1,1,1,married_civ_spouse,5013,7,wife,female,23, 2,married_civ_spouse,5013,C1,wife,female,23,Symbol).

%?-intervene(1,1,1,1,1,1,'Divorced',5013,7,'Unmarried','Female', 2,A1,B1,C1,D1,E1,Symbol).

% Sopam
%?-A = 'no_checking_account', B = 'no credits taken/ all credits paid back duly', C = 'car or other', D .=. 5, E .=. 400, F = 'unemployed', G = 'official/skilled-employee', %G = 'unemployed/unskilled-non-resident', 
%intervene(act(1,1,1,1,1,1,1),wei(1,1,1,1,1,1,1),time(1),original(A,B,C,D,E,F,G), time(Q),counterfactual(A1,B1,C1,D1,E1,F1,G1),Symbol,Cost).




%?-A = 'no_checking_account', B = 'no credits taken/ all credits paid back duly', C = 'car or other', D .=. 5, E .=. 400, F = '>=7_years', G = 'official/skilled-employee', %G = 'unemployed/unskilled-non-resident', 
%intervene(act(1,1,1,1,1,1,1),wei(1,1,1,1,1,1,1),time(1),original(A,B,C,D,E,F,G), time(Q),counterfactual(A1,B1,C1,D1,E1,F1,G1),Symbol,Cost).

%?-A = 'no_checking_account', B = 'no credits taken/ all credits paid back duly', C = 'car or other', D .=. 5, E .=. 400, F = '1=<_and_<4_years', G = 'official/skilled-employee', %G = 'unemployed/unskilled-non-resident', 
%intervene(act(1,1,1,1,1,1,1),wei(2,1,1,1,1,1,1),time(1),original(A,B,C,D,E,F,G), time(Q),counterfactual(A1,B1,C1,D1,E1,F1,G1),Symbol,Cost).
