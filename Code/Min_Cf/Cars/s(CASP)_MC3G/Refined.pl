
refined(original(A,B,C,D),id(Z1,Z2,Z3,Z4),counterfactual(A1,B1,C1,D1),weights(W1,W2,W3,W4),X,cost(O1,O2,O3,O4)):-
	reject(A,B,C,D),
	pre_realistic(A,B,C,D),

	cf_reject(A1,B1,C1,D1),
	post_realistic(A1,B1,C1,D1),
	id_restrict(original(A,B,C,D),id(Z1,Z2,Z3,Z4),counterfactual(A1,B1,C1,D1), pos_id(Q1,Q2,Q3,Q4)), 
	O1 .=. Q1 * W1, O2 .=. Q2 * W2, O3 .=. Q3 * W3, O4 .=. Q4 * W4.
