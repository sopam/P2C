#include('Draft_1_1.pl').

% Domain

f_domain(persons, 'more').
f_domain(persons, '4').
f_domain(persons, '2').
f_domain(safety, 'high').
f_domain(safety, 'med').
f_domain(safety, 'low').
f_domain(buying, 'vhigh').
f_domain(buying, 'med').
f_domain(buying, 'low').
f_domain(buying, 'high').
f_domain(maint, 'vhigh').
f_domain(maint, 'low').
f_domain(maint, 'med').
f_domain(maint, 'high').



% Property
    % Pre-Intervention world
    persons(Time,X) :- f_domain(persons, X).
    safety(Time,X) :- f_domain(safety, X).
    buying(Time,X) :- f_domain(buying, X).
    maint(Time,X) :- f_domain(maint, X).



% Legal: Assigns the property to each instance for a given timestamp
    legal(Time, A,B,C,D) :-
        persons(Time,A), 
        safety(Time,B),
        buying(Time,C),
        maint(Time,D).
    %?- legal(1,A,B,C,D).

    % Q: Decision Rules for negative/ undesired Outcome (’<=50K/yr’)
    rule_1(A):- A = '2'.
    rule_2(B):- B = 'low'.
    rule_3(C,D):- C = 'vhigh', D = 'vhigh'.
    rule_4(C,D):- C \= 'low', C \= 'med', D = 'vhigh'.
    rule_5(C,D):- C = 'vhigh', D = 'high'.

    % Decision rule to classify if a person makes ’<=50K/yr’

	% Uncomment
		%lite_reject(A,_,_,_):- A = 2.
		%lite_reject(_,B,_,_):- B = low.
		%lite_reject(_,_,C,D):- C = vhigh, D = vhigh.
		%lite_reject(_,_,C,D):- C \= low, C \= med, D = vhigh.
		%lite_reject(_,_,C,D):- C = vhigh, D = high.

	lite_reject(A,_,_,_):- rule_1(A).
	lite_reject(_,B,_,_):- rule_2(B).
	lite_reject(_,_,C,D):- rule_3(C,D).
	lite_reject(_,_,C,D):- rule_4(C,D).
	lite_reject(_,_,C,D):- rule_5(C,D).

	reject(Time, A,B,C,D):- legal(Time,A,B,C,D), lite_reject(A,B,C,D).
    ?- reject(1,A,B,C,D).


% not Q: Counterfactual rule
	accept(Time, A,B,C,D):- legal(Time,A,B,C,D), not lite_reject(A,B,C,D).
    %?-accept(1, A,B,C,D).

% Restriction, if 0, cannot change 
	alter(0,X,X).
	alter(1,X,Y).


% Actionability Restriction: if Z_i is 0, its immutable, else it can be altered
    act_restrict(original(A,B,C,D),act(Z1,Z2,Z3,Z4),counterfactual(A1,B1,C1,D1)):- 
        alter(Z1,A,A1), alter(Z2,B,B1), alter(Z3,C,C1), alter(Z4,D,D1).

% Function to get the output costs for each counterfactual per feature
    get_min_cf(original(A,B,C,D),act(Z1,Z2,Z3,Z4),counterfactual(A1,B1,C1,D1),weights(W1,W2,W3,W4),cost(O1,O2,O3,O4)):-
        
        reject(1,A,B,C,D),

        accept(2,A1,B1,C1,D1),

        act_restrict(original(A,B,C,D),act(Z1,Z2,Z3,Z4),counterfactual(A1,B1,C1,D1)), 
        
        O1 .=. Z1 * W1, O2 .=. Z2 * W2, O3 .=. Q3 * W3, O4 .=. Q4 * W4.

    %?-A .=. 0, B .=. 1, C .=. 700, get_min_cf(original(A,B,C),id(Z1,Z2,Z3),counterfactual(A1,B1,C1),weights(W1,W2,W3),cost(O1,O2,O3)).
    ?-F1 .=. 0, F2 .=. 1, F3 .=. 700, get_min_cf(original(F1,F2,F3),act(Z1,Z2,Z3),counterfactual(Cf1,Cf2,Cf3),weights(1,1,1),cost(O1,O2,O3)).





% Path Algorithm



% Direct
    lite_direct(act(Z1,Z2,Z3,Z4),wei(W1,W2,W3,W4),time(P),original(A,B,C,D), time(Q),counterfactual(A1,B1,C1,D1),'<-D1',W1):- 
        alter(Z1,A,A1), 
        alter(Z2,B,B1), 
        alter(Z3,C,C1),
        alter(Z4,D,D1),
        A \= A1, 
        B = B1, 
        C = C1, 
        D = D1.
    lite_direct(act(Z1,Z2,Z3,Z4),wei(W1,W2,W3,W4),time(P),original(A,B,C,D), time(Q),counterfactual(A1,B1,C1,D1),'<-D2',W2):- 
        alter(Z1,A,A1), 
        alter(Z2,B,B1), 
        alter(Z3,C,C1),
        alter(Z4,D,D1),
        A = A1, 
        B \= B1, 
        C = C1, 
        D = D1.

    lite_direct(act(Z1,Z2,Z3,Z4),wei(W1,W2,W3,W4),time(P),original(A,B,C,D), time(Q),counterfactual(A1,B1,C1,D1),'<-D3',W3):- 
        alter(Z1,A,A1), 
        alter(Z2,B,B1), 
        alter(Z3,C,C1),
        alter(Z4,D,D1),
        A = A1, 
        B = B1, 
        C \= C1, 
        D = D1.

    lite_direct(act(Z1,Z2,Z3,Z4),wei(W1,W2,W3,W4),time(P),original(A,B,C,D), time(Q),counterfactual(A1,B1,C1,D1),'<-D4',W4):- 
        alter(Z1,A,A1), 
        alter(Z2,B,B1), 
        alter(Z3,C,C1),
        alter(Z4,D,D1),
        A = A1, 
        B = B1, 
        C = C1, 
        D \= D1.


% Intervene

    lite_intervene(act(Z1,Z2,Z3,Z4),wei(W1,W2,W3,W4),time(P),original(A,B,C,D), time(Q),counterfactual(A1,B1,C1,D1),Symbol, Total_cost):- 
        lite_direct(act(Z1,Z2,Z3,Z4),wei(W1,W2,W3,W4),time(P),original(A,B,C,D), time(Q),counterfactual(A1,B1,C1,D1),Symbol, Total_cost).

%?-P .=. 1, A .=. 1, B .=. 1, C .=. 0, lite_causal(act(1,1,1),wei(1,1,1),time(P),original(A,B,C), time(2),counterfactual(A,B,C1),'<-C',Total_Cost).

%?-P .=. 1, legal(1,A,B,C), legal(2, A, B, C1), A .=. 0, B .=. 1, C .=. 400, constraint(C1,A, Total_Cost).


% With Lite Causal
%?-P .=. 1, Q .=. 2, legal(1,A,B,C), legal(2, A, B, C1), A .=. 0, B .=. 1, C .=. 400, lite_causal(act(1,1,1),wei(1,1,1),time(P),original(A,B,C), time(Q),counterfactual(A,B,C1),Symbol,Total_Cost).
% With Lite intervention (including lite_Direct)
%?-P .=. 1, Q .=. 2, legal(1,A,B,C), legal(2, A1, B1, C1), A .=. 2, B .=. 1, C .=. 400, lite_intervene(act(0,1,1),wei(2,3,4),time(P),original(A,B,C), time(Q),counterfactual(A1,B1,C1),Symbol,Total_Cost).

#show intervene/8.

intervene(act(Z1,Z2,Z3,Z4),wei(W1,W2,W3,W4),time(P),original(A,B,C,D), time(Q),counterfactual(A1,B1,C1,D1),Symbol,Cost):- Q.=. P+1,
                                legal(P,A,B,C,D),
                                legal(Q,A1,B1,C1,D1),
                                lite_intervene(act(Z1,Z2,Z3,Z4),wei(W1,W2,W3,W4),time(P),original(A,B,C,D), time(Q),counterfactual(A1,B1,C1,D1),Symbol,Cost).

% With Intervene



% Function to find the solution path to the counterfactual  

    get_path(act(_,_,_,_),wei(W1,W2,W3,W4),time(TN),original(A1,B1,C1,D1),time(TN),counterfactual(A1,B1,C1,D1),Opt,Opt, O_Effort, O_Effort):-accept(TN,A1,B1,C1,D1).
    
    get_path(act(Z1,Z2,Z3,Z4),wei(W1,W2,W3,W4),time(T1),original(A,B,C,D),time(TN),counterfactual(A1,B1,C1,D1),Acc,Opt, I_Effort, O_Effort):- T1 .=<. TN, I_Effort .=<. O_Effort
        ,intervene(act(Z1,Z2,Z3,Z4),wei(W1,W2,W3,W4),time(T1),original(A,B,C,D),time(T2),counterfactual(A2,B2,C2,D2),Symbol,Cost)
        , anti_member([A2,B2,C2,D2],Acc) 
        , reject(T1,A,B,C,D)
        , Effort_1 .=. I_Effort + Cost
        , get_path(act(Z1,Z2,Z3,Z4),wei(W1,W2,W3,W4),time(T2),original(A2,B2,C2,D2),time(TN),counterfactual(A1,B1,C1,D1),[state(time(T2),[A2,B2,C2,D2]),Symbol|Acc], Opt, Effort_1, O_Effort).





?- O_Effort .=. 2, T1 = 0, F1 = '2', F2 = 'med', F3 = 'high', F4 = 'high',  get_path(act(1,1,1,1),wei(1,1,1,1),time(T1),original(F1,F2,F3,F4), time(TN),counterfactual(Cf1,Cf2,Cf3,Cf4),[state(time(T1),[F1,F2,F3,F4])],Opt, 0, O_Effort).


