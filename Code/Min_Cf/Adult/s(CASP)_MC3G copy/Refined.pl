refined(original(A,B,C,D,E),id(Z1,Z2,Z3,Z4,Z5),counterfactual(A1,B1,C1,D1,E1),weights(W1,W2,W3,W4,W5),X,cost(O1,O2,O3,O4,O5)):-
	less_equal_50K(A,B,C),
	pre_realistic(A,B,C,D,E),

	cf_less_equal_50K(A1,B1,C1),
	post_realistic(A1,B1,C1,D1,E1,inp_cost(Z1,Z4), opt_cost(Q1,Q4)),
	id_restrict(original(A,B,C,D,E),id(Z1,Z2,Z3,Z4,Z5),counterfactual(A1,B1,C1,D1,E1), pos_id(_,Q2,Q3,_,Q5)), 
	%measure(pos_id(Q1,Q2,Q3,Q4,Q5),weights(W1,W2,W3,W4,W5),X).
	O1 .=. Q1 * W1, O2 .=. Q2 * W2, O3 .=. Q3 * W3, O4 .=. Q4 * W4, O5 .=. Q5 * W5.
