

rule_1(A):- A = '2'.
rule_2(B):- B = 'low'.
rule_3(C,D):- C = 'vhigh', D = 'vhigh'.
rule_4(C,D):- C \= 'low', C \= 'med', D = 'vhigh'.
rule_5(C,D):- C = 'vhigh', D = 'high'.

% Decision rule to classify if a person makes ’<=50K/yr’

	% Uncomment
		%lite_reject(A,_,_,_):- A = 2.
		%lite_reject(_,B,_,_):- B = low.
		%lite_reject(_,_,C,D):- C = vhigh, D = vhigh.
		%lite_reject(_,_,C,D):- C \= low, C \= med, D = vhigh.
		%lite_reject(_,_,C,D):- C = vhigh, D = high.

	lite_reject(A,_,_,_):- rule_1(A).
	lite_reject(_,B,_,_):- rule_2(B).
	lite_reject(_,_,C,D):- rule_3(C,D).
	lite_reject(_,_,C,D):- rule_4(C,D).
	lite_reject(_,_,C,D):- rule_5(C,D).

	reject(A,B,C,D):- pre_persons(A), pre_safety(B), pre_buying(C), pre_maint(D), lite_reject(A,B,C,D).
