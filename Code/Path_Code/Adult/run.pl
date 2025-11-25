
#include('get_path.pl').
run(O_Effort,Time_limit, TN, Opt):-
    original_sample(A,B,C,D,E),mutability(Z1,Z2,Z3,Z4,Z5), weight(W1,W2,W3,W4,W5)
    ,TN .=<. Time_limit
    , Z1 = 0, Z2 .=. 1, Z3 = 0, Z4 = 1, Z5 = 0
    , T1 .=. 1
   
    , A1 = 'Married-civ-spouse'
    , B1 .=. 5060
    , C1 .=. 9
    , D1 = 'Husband'
    , E1 = 'Male'

    ,get_path(act(Z1,Z2,Z3,Z4,Z5),wei(W1,W2,W3,W4,W5),time(T1),original(A,B,C,D,E),time(TN),counterfactual(A1,B1,C1,D1,E1),[],[state(time(T1),[A,B,C,D,E])],Opt, 0, O_Effort).
    

% If the first argument is 1, it'll search for paths with a length of 1.
% If the first argument is 1, it'll search for paths with a length of 2.

?- run(2,_,TN, Path).