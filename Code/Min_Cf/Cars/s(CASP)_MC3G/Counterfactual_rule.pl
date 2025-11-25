% Counterfactual rule to clasify if a person does nothave good credit

	cf_reject(A,B,C,D):- post_persons(A), post_safety(B), post_buying(C),  post_maint(D), not lite_reject(A,B,C,D).

