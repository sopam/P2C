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
	measure(pos_id(Q1,Q2,Q3,Q4,Q5,Q6,Q7),weights(W1,W2,W3,W4,W5,W6,W7),X):- X .=. (W1*Q1)+(W2*Q2)+(W3*Q3)+(W4*Q4)+(W5*Q5)+(W6*Q6)+(W7*Q7).


id_restrict(original(A,B,C,D,E,F,G),id(Z1,Z2,Z3,Z4,Z5,Z6,Z7),counterfactual(A1,B1,C1,D1,E1,F1,G1), pos_id(Q1,Q2,Q3,Q4,Q5,Q6,Q7)):- 
	compare_C(A,A1,Z1), compare_C(B,B1,Z2), compare_C(C,C1,Z3),
	compare_N(D,D1,Z4), compare_N(E,E1,Z5), 
	compare_C(F,F1,Z6), compare_C(G,G1,Z7),
    square(Z1,Q1), square(Z2,Q2), square(Z3,Q3), square(Z4,Q4), square(Z5,Q5), square(Z6,Q6), square(Z7,Q7) .
