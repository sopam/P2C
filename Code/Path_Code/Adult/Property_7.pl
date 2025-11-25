#include('Domain_7.pl').

% Pre-Intervention world
marital_status(Y,X) :- f_domain(marital_status, X).



% Post-Intervention world
capital_gain(Y,X) :- f_domain(capital_gain, X).



% Post-Intervention world
education_num(Y,X) :- f_domain(education_num, X).



% Post-Intervention world
relationship(Y,X) :- f_domain(relationship, X).




% Post-Intervention world
sex(Y,X) :- f_domain(sex, X).




%?- age(1,X).