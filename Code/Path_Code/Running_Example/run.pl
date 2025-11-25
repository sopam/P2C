#include('Draft_1_1.pl').

% Domain

    f_domain(debt,X):- X .>=. 0, X .=<. 1000000.
    f_domain(bank_balance, X) :- X .>=. 0, X .=<. 1000000.
    f_domain(credit_score, X) :- X .>=. 300, X .=<. 850.


% Property
    debt(Time,X) :- f_domain(debt, X).
    bank_balance(Time,X) :- f_domain(bank_balance, X).
    credit_score(Time,X) :- f_domain(credit_score, X).



% Legal: Assigns the property to each instance for a given timestamp
    legal(Time, X,Y,Z) :-
        debt(Time,X), 
        bank_balance(Time,Y),
        credit_score(Time,Z).
    %?- legal(1, X,Y,Z).


% Causal Constraints
    #show constraint/3.
    constraint(Z,X, 0):- Z .=<. 619, X .>. 0.
    constraint(Z,X, 0):- Z .>. 619, X .=. 0.
    %constraint(Z,X, 0):- Z .>. 500, Z .=<. 619, X .>. 0, X .=<. 10000.
    %constraint(Z,X, 0):- Z .<. 500, X .>. 10000.
    
    %?- legal(1, X,Y,Z),reject_loan(1,Y,Z) , constraint(Z,X, cost(_,0)).

% Q: Decision Rules for negative/ undesired Outcome (’<=50K/yr’)
	#show lite_reject_loan/2, not lite_reject_loan/2.
    lite_reject_loan(_,B,_) :- B .<. 60000.
    lite_reject_loan(_,_,C) :- C .<. 620.

    reject_loan(Time,A,B,C):- legal(Time,A,B,C), lite_reject_loan(A,B,C).
    %?-reject_loan(1,A,B,C).

% not Q: Counterfactual rule
	accept_loan(Time,A,B,C):- legal(Time,A,B,C), not lite_reject_loan(A,B,C).
    %?-accept_loan_loan(1,A,B,C).

% Restriction, if 0, cannot change 
	alter(0,X,X).
	alter(1,X,Y).


% Actionability Restriction: if Z_i is 0, its immutable, else it can be altered
    act_restrict(original(A,B,C),act(Z1,Z2,Z3),counterfactual(A1,B1,C1)):- 
        alter(Z1,A,A1), alter(Z2,B,B1), alter(Z3,C,C1).

% Function to get the output costs for each counterfactual per feature
    get_min_cf(original(A,B,C),act(Z1,Z2,Z3),counterfactual(A1,B1,C1),weights(W1,W2,W3),cost(O1,O2,O3)):-
        
        %legal(1,A,B,C),
        constraint(C,A,_),
        %lite_reject_loan(A,B,C),
        reject_loan(1,A,B,C),

        %legal(2,A1,B1,C1),
        constraint(C1,A1,Q3),
        %not lite_reject_loan(A1,B1,C1),
        accept_loan(1,A1,B1,C1),

        act_restrict(original(A,B,C),act(Z1,Z2,Z3),counterfactual(A1,B1,C1)), 
        
        O1 .=. Z1 * W1, O2 .=. Z2 * W2, O3 .=. Q3 * W3.

    %?-A .=. 0, B .=. 1, C .=. 700, get_min_cf(original(A,B,C),id(Z1,Z2,Z3),counterfactual(A1,B1,C1),weights(W1,W2,W3),cost(O1,O2,O3)).
    ?-F1 .=. 0, F2 .=. 1, F3 .=. 700, get_min_cf(original(F1,F2,F3),act(Z1,Z2,Z3),counterfactual(Cf1,Cf2,Cf3),weights(1,1,1),cost(O1,O2,O3)).





% Path Algorithm



% Direct
    lite_direct(act(Z1,Z2,Z3),wei(W1,W2,W3),time(P),original(A,B,C), time(Q),counterfactual(A1,B1,C1),'<-D1',W1):- 
        alter(Z1,A,A1), 
        alter(Z2,B,B1), 
        alter(Z3,C,C1),
        A \= A1, 
        B = B1, 
        C = C1.

    lite_direct(act(Z1,Z2,Z3),wei(W1,W2,W3),time(P),original(A,B,C), time(Q),counterfactual(A1,B1,C1),'<-D2',W2):- 
        alter(Z1,A,A1), 
        alter(Z2,B,B1), 
        alter(Z3,C,C1),
        A = A1, 
        B \= B1, 
        C = C1.



%   Causal
    %#show lite_causal/10.
    % Combines the changes over the marital status and relationship Status'):- 
    lite_causal(act(Z1,Z2,Z3),wei(W1,W2,W3),time(P),original(A,B,C), time(Q),counterfactual(A,B,C1),'<-C',Total_Cost):- constraint(C1,A, Total_Cost).

% Intervene
    lite_intervene(act(Z1,Z2,Z3),wei(W1,W2,W3),time(P),original(A,B,C), time(Q),counterfactual(A,B,C1),Symbol, Total_Cost):- 
        lite_causal(act(Z1,Z2,Z3),wei(W1,W2,W3),time(P),original(A,B,C), time(Q),counterfactual(A,B,C1),Symbol,Total_Cost).



    lite_intervene(act(Z1,Z2,Z3),wei(W1,W2,W3),time(P),original(A,B,C), time(Q),counterfactual(A1,B1,C1),Symbol, Total_cost):- 
        lite_direct(act(Z1,Z2,Z3),wei(W1,W2,W3),time(P),original(A,B,C), time(Q),counterfactual(A1,B1,C1),Symbol, Total_cost).

%?-P .=. 1, A .=. 1, B .=. 1, C .=. 0, lite_causal(act(1,1,1),wei(1,1,1),time(P),original(A,B,C), time(2),counterfactual(A,B,C1),'<-C',Total_Cost).

%?-P .=. 1, legal(1,A,B,C), legal(2, A, B, C1), A .=. 0, B .=. 1, C .=. 400, constraint(C1,A, Total_Cost).


% With Lite Causal
%?-P .=. 1, Q .=. 2, legal(1,A,B,C), legal(2, A, B, C1), A .=. 0, B .=. 1, C .=. 400, lite_causal(act(1,1,1),wei(1,1,1),time(P),original(A,B,C), time(Q),counterfactual(A,B,C1),Symbol,Total_Cost).
% With Lite intervention (including lite_Direct)
%?-P .=. 1, Q .=. 2, legal(1,A,B,C), legal(2, A1, B1, C1), A .=. 2, B .=. 1, C .=. 400, lite_intervene(act(0,1,1),wei(2,3,4),time(P),original(A,B,C), time(Q),counterfactual(A1,B1,C1),Symbol,Total_Cost).

#show intervene/8.

intervene(act(Z1,Z2,Z3),wei(W1,W2,W3),time(P),original(A,B,C), time(Q),counterfactual(A1,B1,C1),Symbol,Cost):- Q.=. P+1,
                                legal(P,A,B,C),
                                legal(Q,A1,B1,C1),
                                lite_intervene(act(Z1,Z2,Z3),wei(W1,W2,W3),time(P),original(A,B,C), time(Q),counterfactual(A1,B1,C1),Symbol,Cost).

% With Intervene
?-P .=. 1, Q .=. 2, A .=. 2, B .=. 1, C .=. 400, intervene(act(0,1,1),wei(2,3,4),time(P),original(A,B,C), time(Q),counterfactual(A1,B1,C1),Symbol,Total_Cost).


% With reject loan


?-P .=. 1, Q .=. 2, A .=. 0, B .=. 1, C .=. 601,  reject_loan(Q,B1,C1), intervene(act(1,0,1),wei(2,3,4),time(P),original(A,B,C), time(Q),counterfactual(A1,B1,C1),Symbol,Total_Cost).




% Function to find the solution path to the counterfactual  

    get_path(act(_,_,_),wei(W1,W2,W3),time(TN),original(A1,B1,C1),time(TN),counterfactual(A1,B1,C1),Opt,Opt, O_Effort, O_Effort):-accept_loan(TN,A1,B1,C1), constraint(C1,A1, _).
    
    get_path(act(Z1,Z2,Z3),wei(W1,W2,W3),time(T1),original(A,B,C),time(TN),counterfactual(A1,B1,C1),Acc,Opt, I_Effort, O_Effort):- T1 .=<. TN, I_Effort .=<. O_Effort
        ,intervene(act(Z1,Z2,Z3),wei(W1,W2,W3),time(T1),original(A,B,C),time(T2),counterfactual(A2,B2,C2),Symbol,Cost)
        , anti_member([A2,B2,C2],Acc) 
        , reject_loan(T1,A,B,C)
        , Effort_1 .=. I_Effort + Cost
        , get_path(act(Z1,Z2,Z3),wei(W1,W2,W3),time(T2),original(A2,B2,C2),time(TN),counterfactual(A1,B1,C1),[state(time(T2),[A2,B2,C2]),Symbol|Acc], Opt, Effort_1, O_Effort).


% Removed no_Rep and Antimember 2
?- O_Effort .=. 2, P .=. 0, A .=. 0, B .=. 40000, C .=. 621,  get_path(act(1,1,1),wei(2,2,2),time(P),original(A,B,C),time(TN),counterfactual(A1,B1,C1),[state(time(T1),[A,B,C])],Opt, 0, O_Effort).
%?- O_Effort .=. 1, TN = 1, P .=. 0, A .=. 0, B .=. 1, C .=. 621,  get_path(act(1,1,1),wei(1,1,1),time(P),original(A,B,C),time(TN),counterfactual(A1,B1,C1),[state(time(T1),[A,B,C])],Opt, 0, O_Effort).



    %?-F1 .=. 0, F2 .=. 1, F3 .=. 700, get_min_cf(original(F1,F2,F3),act(Z1,Z2,Z3),counterfactual(Cf1,Cf2,Cf3),weights(1,1,1),X,cost(O1,O2,O3)).

 ?-F1 .=. 0, F2 .=. 1, F3 .=. 700, get_min_cf(original(F1,F2,F3),act(Z1,Z2,Z3),counterfactual(Cf1,Cf2,Cf3),weights(1,1,1),cost(O1,O2,O3)).




?- O_Effort .=. 2, P .=. 0, A .=. 5000, B .=. 40000, C .=. 599,  get_path(act(1,1,1),wei(1,1,1),time(P),original(A,B,C),time(TN),counterfactual(A1,B1,C1),[state(time(T1),[A,B,C])],Opt, 0, O_Effort).
