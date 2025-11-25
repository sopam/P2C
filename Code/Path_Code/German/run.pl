#include('get_path.pl').

run(O_Effort,Time_limit, TN, Opt):-
    original_sample(A,B,C,D,E,F,G), actionability(Z1,Z2,Z3,Z4,Z5,Z6,Z7), weight(W1,W2,W3,W4,W5,W6,W7) 
    ,TN .=<. Time_limit
    , T1 .=. 0, 
    get_path(act(Z1,Z2,Z3,Z4,Z5,Z6,Z7),wei(1,1,1,1,1,1,1),time(T1),original(A,B,C,D,E,F,G),time(TN),counterfactual(A1,B1,C1,D1,E1,F1,G1),[],[state(time(T1),[A,B,C,D,E,F,G])],Opt, 0, O_Effort).



?-run(2,Time_limit, TN, Opt).