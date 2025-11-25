% Counterfactual rule to clasify if a person does not make ’<=50K/yr’
	cf_less_equal_50K(A,B,C):- f_domain(marital_status, A),
	f_domain(capital_gain, B), f_domain(education_num, C),
	post_marital_status(A), post_capital_gain(B),post_education_num(C), 
	not lite_le_50K(A,B,C).

%% QUERY
%?- cf_less_equal_50K(A,B,C).
