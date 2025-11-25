	pre_realistic(A,B,C,D,E,F,G):-
		pre_checking_account_status(A),    pre_credit_history(B),   pre_property(C),   pre_duration_months(D),   pre_credit_amount(E),
		pre_present_employment_since(F), pre_job(G),
		constraint_pres_job(F,G,cost(_,_)).


	post_realistic(A,B,C,D,E,F,G,inp_cost(Inp_Pres),opt_cost(Opt_Pres)):-
		post_checking_account_status(A),    post_credit_history(B),   post_property(C),   post_duration_months(D),   post_credit_amount(E),
		post_present_employment_since(F), post_job(G),
		constraint_pres_job(F,G,cost(Inp_Pres,Opt_Pres)).



