
% Constraint rules identify causal relationships amongst features.
% They restrict the values taken for relationship(Y) and age(Z)
    #show constraint_ms_reln/3.
    %constraint_ms_reln_age('Married-civ-spouse',Y):- Y = 'Husband'.
    %constraint_ms_reln_age('Married-civ-spouse',Y):- Y = 'Wife'.
    %constraint_ms_reln_age('Never-married',Y):- Y \= 'Husband', Y\= 'Wife'.

% Add the rule to catch all other cases
    %constraint_ms_reln_age(X,Y):- X\= 'Married-civ-spouse', X\= 'Never-married', Y \= 'Husband', Y\= 'Wife'.
    

    


    constraint_ms_reln('Married-civ-spouse',Y, cost(_,0)):- Y = 'Husband'.
    constraint_ms_reln('Married-civ-spouse',Y, cost(_,0)):- Y = 'Wife'.

    constraint_ms_reln('Never-married',Y, cost(_,0)):- Y = 'Unmarried'.
    constraint_ms_reln('Divorced',Y, cost(_,0)):- Y = 'Unmarried'.
    constraint_ms_reln('Separated',Y, cost(_,0)):- Y = 'Unmarried'.
	
	%constraint_ms_reln('Never-married',Y, cost(_,0)):- Y = 'Not-in-family'.
    
    


    
    



% Constraint rules that restrict age and sex for relationship
    #show constraint_reln_sex/3.

    constraint_reln_sex('Unmarried',Y, cost(_,0)):- Y= 'Male'.
% There is no rule for wife, so we put a rule to allow the same
    constraint_reln_sex('Unmarried',Y, cost(_,0)):- Y= 'Female'.




% Constraint rules that restrict age and sex for relationship
	constraint_reln_sex('Husband',Y, cost(_,0)):- Y = 'Male'.
% There is no rule for wife, so we put a rule to allow the same
	%constraint_reln_sex('Wife',Y, cost(_,0)):- Y= 'Female'.
% Add the rule to catch all other cases
	%constraint_reln_sex(X,_, cost(Inp,Inp)):- X \= 'Husband', X \= 'Wife'.