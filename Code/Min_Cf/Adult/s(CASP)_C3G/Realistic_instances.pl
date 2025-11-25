	pre_realistic(A,B,C,D,E):-
		pre_marital_status(A),
		pre_capital_gain(B),pre_education_num(C), 
		pre_relationship(D), pre_sex(E), 
		constraint_ms_reln(A,D,cost(_,_)), constraint_reln_sex(D,E,cost(_,_)).



	post_realistic(A,B,C,D,E,inp_cost(Inp_Ms, Inp_Reln), opt_cost(Opt_Ms, Opt_Reln)):-
		post_marital_status(A),
		post_capital_gain(B),post_education_num(C), 
		post_relationship(D), post_sex(E), 
		constraint_ms_reln(A,D,cost(Inp_Ms,Opt_Ms)), constraint_reln_sex(D,E,cost(Inp_Reln,Opt_Reln)).

