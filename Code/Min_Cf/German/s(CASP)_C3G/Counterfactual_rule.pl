% Counterfactual rule to clasify if a person does nothave good credit


	cf_good_credit(A,B,C,D,E):- f_domain(checking_account_status,A),    f_domain(credit_history,B),   f_domain(property,C),   
	f_domain(duration_months,D),   f_domain(credit_amount,E),
	post_checking_account_status(A),    post_credit_history(B),   post_property(C),   post_duration_months(D),   post_credit_amount(E),
	not lite_good_credit(A,B,C,D,E).



