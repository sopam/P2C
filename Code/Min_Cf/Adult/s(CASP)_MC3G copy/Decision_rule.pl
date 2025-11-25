% Decision rule to classify if a person makes ’<=50K/yr’
	lite_le_50K(X,Y,_) :- X \= 'Married-civ-spouse', Y .=<. 6849.0.
	lite_le_50K(X,Y,Z) :- X = 'Married-civ-spouse', Y .=<. 5013.0, Z .=<. 12.0.

	%less_equal_50K(A,B,C):- pre_marital_status(A), pre_capital_gain(B),pre_education_num(C), 
%		lite_le_50K(A,B,C).


	less_equal_50K(A,B,C):- pre_marital_status(A), pre_capital_gain(B),pre_education_num(C).

