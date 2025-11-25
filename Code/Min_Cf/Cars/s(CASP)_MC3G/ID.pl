% Identify and Restrict: Identify the features to be intervened on / Restrict features to be intervened on


% Control Features:

	compare_C(X,X,0).
	compare_C(X,Y,1):- X \= Y.


	compare_N(X,X,0).
	compare_N(X,Y,1):- X .<. Y.
	compare_N(X,Y,-1):- X .>. Y.

% Measure
	%f_domain(control,0).
	%f_domain(control,1).
	%f_domain(control_N,0).
	%f_domain(control_N,1).
	%f_domain(control_N,-1).



% square()
    square(X,Y):- Y .=. X*X.

	#show measure/13.
	measure(pos_id(Q1,Q2,Q3,Q4),weights(W1,W2,W3,W4),X):- X .=. (W1*Q1)+(W2*Q2)+(W3*Q3)+(W4*Q4).


id_restrict(original(A,B,C,D),id(Z1,Z2,Z3,Z4),counterfactual(A1,B1,C1,D1), pos_id(Q1,Q2,Q3,Q4)):- 
	compare_C(A,A1,Z1), compare_C(B,B1,Z2), compare_C(C,C1,Z3),
	compare_C(D,D1,Z4),
    square(Z1,Q1), square(Z2,Q2), square(Z3,Q3), square(Z4,Q4).
