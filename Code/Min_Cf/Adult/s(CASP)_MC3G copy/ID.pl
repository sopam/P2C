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
	measure(pos_id(Q1,Q2,Q3,Q4,Q5),weights(W1,W2,W3,W4,W5),X):- X .=. (W1*Q1)+(W2*Q2)+(W3*Q3)+(W4*Q4)+(W5*Q5).


id_restrict(original(A,B,C,D,E),id(Z1,Z2,Z3,Z4,Z5),counterfactual(A1,B1,C1,D1,E1), pos_id(Q1,Q2,Q3,Q4,Q5)):- 
	compare_C(A,A1,Z1), compare_N(B,B1,Z2), compare_N(C,C1,Z3),
	compare_C(D,D1,Z4), compare_C(E,E1,Z5), 
    square(Z1,Q1), square(Z2,Q2), square(Z3,Q3), square(Z4,Q4), square(Z5,Q5) .
