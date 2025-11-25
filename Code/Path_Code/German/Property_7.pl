#include('Domain_7.pl').

% Pre-Intervention world
checking_account_status(Y,X) :- f_domain(checking_account_status, X).



% Post-Intervention world
credit_history(Y,X) :- f_domain(credit_history, X).



% Post-Intervention world
property(Y,X) :- f_domain(property, X).



% Post-Intervention world
duration_months(Y,X) :- f_domain(duration_months, X).




% Post-Intervention world
credit_amount(Y,X) :- f_domain(credit_amount, X).


% Post-Intervention world
present_employment_since(Y,X) :- f_domain(present_employment_since, X).

% Post-Intervention world
job(Y,X) :- f_domain(job, X).

%?- age(1,X).