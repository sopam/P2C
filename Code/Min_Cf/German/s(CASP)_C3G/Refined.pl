
refined(original(A,B,C,D,E,F,G),id(Z1,Z2,Z3,Z4,Z5,Z6,Z7),counterfactual(A1,B1,C1,D1,E1,F1,G1),weights(W1,W2,W3,W4,W5,W6,W7),X,cost(O1,O2,O3,O4,O5,O6,O7)):-
	good_credit(A,B,C,D,E),
	pre_realistic(A,B,C,D,E,F,G),

	cf_good_credit(A1,B1,C1,D1,E1),
	post_realistic(A1,B1,C1,D1,E1,F1,G1,inp_cost(Z6), opt_cost(Q6)),
	id_restrict(original(A,B,C,D,E,F,G),id(Z1,Z2,Z3,Z4,Z5,Z6,Z7),counterfactual(A1,B1,C1,D1,E1,F1,G1), pos_id(Q1,Q2,Q3,Q4,Q5,_,Q7)), 
	%measure(pos_id(Q1,Q2,Q3,Q4,Q5),weights(W1,W2,W3,W4,W5),X).
	O1 .=. Q1 * W1, O2 .=. Q2 * W2, O3 .=. Q3 * W3, O4 .=. Q4 * W4, O5 .=. Q5 * W5, O6 .=. Q6 * W6, O7 .=. Q7 * W7.
